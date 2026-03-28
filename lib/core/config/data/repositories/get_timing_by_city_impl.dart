import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:injectable/injectable.dart';
import 'package:ummah/core/errors/error_handler.dart';
import 'package:ummah/core/network/network_info.dart';
import 'package:ummah/core/services/api_client_service.dart';
import 'package:ummah/core/config/data/data_sources/prayer_local_data_source.dart';
import 'package:ummah/core/config/data/models/timing_model.dart';
import 'package:ummah/core/config/domain/entities/timing_entity.dart';
import 'package:ummah/core/config/domain/repositories/get_timing_by_city.dart';

@LazySingleton(as: GetTimingByCity)
class GetTimingByCityImpl implements GetTimingByCity {
  final ApiClientService _apiClientService;
  final PrayerLocalDataSource _homeLocalDataSource;
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
      final DateTime now = DateTime.now();
      final String todayDate = DateFormat('dd-MM-yyyy').format(now);

      // 1. Check Cache First (returns the whole month)
      final TimingModel? cachedMonthTimings = _homeLocalDataSource.getTimings(city);

      if (cachedMonthTimings != null && cachedMonthTimings.data != null) {
        final todayData = cachedMonthTimings.data!.firstWhere(
          (element) => element.date?.gregorian?.date == todayDate,
          orElse: () => cachedMonthTimings.data!.first, // Fallback if needed
        );
        return Right(todayData.toEntity());
      }

      // 2. If no cache, check Internet Connection
      final isConnected = await _networkInfo.isConnected;

      if (isConnected) {
        final TimingModel monthTimings = await _apiClientService.getCalendarByCity(
          city: city,
          country: country,
          month: now.month,
          year: now.year,
        );

        // 3. Save newly fetched month data to Cache
        await _homeLocalDataSource.saveTimings(monthTimings, city);

        final todayData = monthTimings.data!.firstWhere(
          (element) => element.date?.gregorian?.date == todayDate,
          orElse: () => monthTimings.data!.first,
        );

        return Right(todayData.toEntity());
      } else {
        return const Left("No internet connection and no cached data found.");
      }
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
  
  @override
  Future<Either<String, List<TimingEntity>>> getMonthTimings({required String city, required String country}) async {
    try {
      final TimingModel? cached = _homeLocalDataSource.getTimings(city);
      if (cached != null && cached.data != null) {
        final List<TimingEntity> allMonth = cached.data!.map((e) => e.toEntity()).toList();
        return Right(allMonth);
      }
      return Left("Try Again Later");
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
