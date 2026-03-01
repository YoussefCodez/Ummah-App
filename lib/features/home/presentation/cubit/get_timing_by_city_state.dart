part of 'get_timing_by_city_cubit.dart';

@immutable
sealed class GetTimingByCityState {}

final class GetTimingByCityInitial extends GetTimingByCityState {}

final class GetTimingByCityLoading extends GetTimingByCityState {}

final class GetTimingByCitySuccess extends GetTimingByCityState {
  final TimingEntity timingEntity;
  final List<SalwatStrategy> salwat;
  final (int, int) activeAndNextIndex;
  GetTimingByCitySuccess({
    required this.timingEntity,
    required this.salwat,
    required this.activeAndNextIndex,
  });
}

final class GetTimingByCityFailure extends GetTimingByCityState {
  final String error;

  GetTimingByCityFailure({required this.error});
}
