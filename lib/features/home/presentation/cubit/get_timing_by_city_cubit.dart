import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:ummah/features/home/domain/entities/timing_entity.dart';
import 'package:ummah/features/home/domain/use_cases/get_timing_by_city_usecase.dart';
import 'package:ummah/features/home/presentation/cubit/salwat_strategy.dart';
import 'package:ummah/core/services/notification_service.dart';
import 'package:ummah/core/constants/app_strings.dart';
import 'package:ummah/features/home/domain/entities/timing_date_time.dart';

part 'get_timing_by_city_state.dart';

@LazySingleton()
class GetTimingByCityCubit extends Cubit<GetTimingByCityState> {
  final GetTimingByCityUsecase getTimingByCityUsecase;
  final NotificationService notificationService;
  Timer? _updateTimer;

  GetTimingByCityCubit(this.getTimingByCityUsecase, this.notificationService)
    : super(GetTimingByCityInitial());

  Future<void> getTimingByCity({
    required String city,
    required String country,
  }) async {
    emit(GetTimingByCityLoading());
    final result = await getTimingByCityUsecase.call(
      city: city,
      country: country,
    );
    result.fold((failure) => emit(GetTimingByCityFailure(error: failure)), (
      timingEntity,
    ) {
      emit(
        GetTimingByCitySuccess(
          timingEntity: timingEntity,
          salwat: timingEntity.getSalwatStrategies(),
          activeAndNextIndex: timingEntity.getActiveAndNextIndex(),
        ),
      );
      _schedulePrayers(timingEntity);
      _startTimer();
    });
  }

  void _schedulePrayers(TimingEntity timing) {
    final prayers = {
      0: (AppStrings.fajrAr, timing.fajrDateTime),
      1: (AppStrings.dhuhrAr, timing.dhuhrDateTime),
      2: (AppStrings.asrAr, timing.asrDateTime),
      3: (AppStrings.maghribAr, timing.maghribDateTime),
      4: (AppStrings.ishaAr, timing.ishaDateTime),
    };

    prayers.forEach((id, data) {
      final name = data.$1;
      var time = data.$2;

      if (time.isBefore(DateTime.now())) {
        time = time.add(const Duration(days: 1));
      }

      notificationService.scheduleNotification(
        id: id,
        title: "${AppStrings.notificationTitle} $name",
        body: "${AppStrings.notificationBody} $name",
        scheduledDate: time,
      );
    });
  }

  void _startTimer() {
    _updateTimer?.cancel();
    _updateTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (state is GetTimingByCitySuccess) {
        final currentState = state as GetTimingByCitySuccess;
        final newIndices = currentState.timingEntity.getActiveAndNextIndex();
        if (newIndices.$1 != currentState.activeAndNextIndex.$1 ||
            newIndices.$2 != currentState.activeAndNextIndex.$2) {
          emit(
            GetTimingByCitySuccess(
              timingEntity: currentState.timingEntity,
              salwat: currentState.salwat,
              activeAndNextIndex: newIndices,
            ),
          );
        }
      }
    });
  }

  @override
  Future<void> close() {
    _updateTimer?.cancel();
    return super.close();
  }
}
