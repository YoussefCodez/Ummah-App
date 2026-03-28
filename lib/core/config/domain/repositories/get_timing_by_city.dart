import 'package:dartz/dartz.dart';
import 'package:ummah/core/config/domain/entities/timing_entity.dart';

abstract interface class GetTimingByCity {
  Future<Either<String, TimingEntity>> getTimingByCity({
    required String city,
    required String country,
  });
  Future<Either<String, List<TimingEntity>>> getMonthTimings({
    required String city,
    required String country,
  });
}