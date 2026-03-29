import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:ummah/core/config/domain/entities/timing_entity.dart';
import 'package:ummah/core/config/domain/use_cases/get_timing_by_city_usecase.dart';
import 'package:ummah/core/services/hive_service.dart';

part 'get_prayers_state.dart';

@injectable
class GetPrayersCubit extends Cubit<GetPrayersState> {
  final GetTimingByCityUsecase _getTimingByCityUsecase;
  final HiveService _hiveService;
  GetPrayersCubit(this._getTimingByCityUsecase, this._hiveService) : super(GetPrayersInitial());

  Future<void> getMonthTimings() async {
    emit(GetPrayersLoading());
    final location = _hiveService.getLocation();
    final lat = _hiveService.getLatitude();
    final long = _hiveService.getLongitude();
    final locationParts = location.split(", ");
    final city = locationParts[0];
    final country = locationParts[1];
    final result = await _getTimingByCityUsecase.getMonthTimings(
      city: city,
      country: country,
      latitude: lat,
      longitude: long,
    );
    result.fold(
      (error) => emit(GetPrayersError(error: error)),
      (prayers) => emit(GetPrayersSuccess(prayers: prayers)),
    );
  }
}
