import 'package:dartz/dartz.dart';
import 'package:ummah/features/home/domain/entities/timing_entity.dart';

abstract interface class GetTimingByCity {
  Future<Either<String, TimingEntity>> getTimingByCity({
    required String city,
    required String country,
  });
}