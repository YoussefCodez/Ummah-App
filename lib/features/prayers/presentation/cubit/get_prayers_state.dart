part of 'get_prayers_cubit.dart';

@immutable
sealed class GetPrayersState {}

final class GetPrayersInitial extends GetPrayersState {}

final class GetPrayersLoading extends GetPrayersState {}

final class GetPrayersSuccess extends GetPrayersState {
  final List<TimingEntity> prayers;
  GetPrayersSuccess({required this.prayers});
}

final class GetPrayersError extends GetPrayersState {
  final String error;
  GetPrayersError({required this.error});
}