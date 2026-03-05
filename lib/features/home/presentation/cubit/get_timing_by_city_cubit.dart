import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
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
  final InternetConnection internetConnection;

  Timer? _updateTimer;
  Timer? _midnightTimer;
  StreamSubscription<InternetStatus>? _connectivitySubscription;

  String? _lastCity;
  String? _lastCountry;

  GetTimingByCityCubit(
    this.getTimingByCityUsecase,
    this.notificationService,
    this.internetConnection,
  ) : super(GetTimingByCityInitial());

  Future<void> getTimingByCity({
    required String city,
    required String country,
  }) async {
    _lastCity = city;
    _lastCountry = country;

    emit(GetTimingByCityLoading());

    final result = await getTimingByCityUsecase.call(
      city: city,
      country: country,
    );

    result.fold(
      (failure) {
        emit(GetTimingByCityFailure(error: failure));
        _listenForConnectivity();
      },
      (timingEntity) {
        emit(
          GetTimingByCitySuccess(
            timingEntity: timingEntity,
            salwat: timingEntity.getSalwatStrategies(),
            activeAndNextIndex: timingEntity.getActiveAndNextIndex(),
          ),
        );
        _schedulePrayers(timingEntity);
        _startMinuteTimer();
        _scheduleMidnightRefetch();
        _connectivitySubscription?.cancel();
        _connectivitySubscription = null;
      },
    );
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
        title: '${AppStrings.notificationTitle} $name',
        body: '${AppStrings.notificationBody} $name',
        scheduledDate: time,
      );
    });
  }

  void _listenForConnectivity() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = internetConnection.onStatusChange.listen((
      status,
    ) {
      if (status == InternetStatus.connected &&
          _lastCity != null &&
          _lastCountry != null) {
        _connectivitySubscription?.cancel();
        _connectivitySubscription = null;
        getTimingByCity(city: _lastCity!, country: _lastCountry!);
      }
    });
  }

  void _startMinuteTimer() {
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

  void _scheduleMidnightRefetch() {
    _midnightTimer?.cancel();
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    final durationUntilMidnight = midnight.difference(now);

    _midnightTimer = Timer(durationUntilMidnight, () {
      if (_lastCity != null && _lastCountry != null) {
        getTimingByCity(city: _lastCity!, country: _lastCountry!);
      }
    });
  }

  @override
  Future<void> close() {
    _updateTimer?.cancel();
    _midnightTimer?.cancel();
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
