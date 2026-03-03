import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ummah/core/errors/error_handler.dart';
import 'package:ummah/core/network/network_info.dart';
import 'package:ummah/core/services/api_client_service.dart';
import 'package:ummah/features/home/data/models/timing_model.dart';
import 'package:ummah/features/home/domain/entities/timing_entity.dart';
import 'package:ummah/features/home/domain/repositories/get_timing_by_city.dart';
import 'package:ummah/features/home/data/data_sources/home_local_data_source.dart';

@LazySingleton(as: GetTimingByCity)
class GetTimingByCityImpl implements GetTimingByCity {
  final ApiClientService _apiClientService;
  final HomeLocalDataSource _homeLocalDataSource;
  final NetworkInfo _networkInfo;

  GetTimingByCityImpl(
    this._apiClientService,
    this._homeLocalDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<String, TimingEntity>> getTimingByCity({
    required String city,
    required String country,
  }) async {
    try {
      // 1. Check Cache First
      final cachedTimings = _homeLocalDataSource.getTimings(city);
      if (cachedTimings != null) {
        return Right(cachedTimings.toEntity());
      }

      // 2. If no cache, check Internet Connection
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        final TimingModel timingModel = await _apiClientService
            .getTimingsByCity(city: city, country: country);

        // 3. Save newly fetched data to Cache
        await _homeLocalDataSource.saveTimings(timingModel, city);

        return Right(timingModel.toEntity());
      } else {
        return const Left("No internet connection and no cached data found.");
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
