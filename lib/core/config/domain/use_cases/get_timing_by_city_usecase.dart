import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ummah/core/config/domain/entities/timing_entity.dart';
import 'package:ummah/core/config/domain/repositories/get_timing_by_city.dart';

@LazySingleton()
class GetTimingByCityUsecase {
  final GetTimingByCity _getTimingByCity;

  GetTimingByCityUsecase(this._getTimingByCity);

  Future<Either<String, TimingEntity>> call({
    required String city,
    required String country,
  }) async {
    return await _getTimingByCity.getTimingByCity(city: city, country: country);
  }

  Future<Either<String, List<TimingEntity>>> getMonthTimings({
    required String city,
    required String country,
  }) async {
    return await _getTimingByCity.getMonthTimings(city: city, country: country);
  }
}