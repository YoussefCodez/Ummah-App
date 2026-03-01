import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ummah/core/services/get_it_service.dart';
import 'package:ummah/core/services/hive_service.dart';
import 'package:ummah/core/services/location_service.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationService _locationService;
  LocationCubit(this._locationService) : super(LocationInitial());

  Future<void> fetchGovernorate() async {
    final hiveService = getIt<HiveService>();
    final cached = hiveService.getLocation();
    final cachedDate = hiveService.getDate();

    try {
      if (cached.isNotEmpty) {
        emit(LocationSuccess(cached, cachedDate));
      } else {
        emit(LocationLoading());
      }

      final result = await _locationService.getCurrentGovernorate();
      final isValid =
          result.isNotEmpty &&
          !result.contains("Couldn't") &&
          !result.contains("permission") &&
          !result.contains("enable") &&
          !result.contains("denied") &&
          !result.contains("disabled") &&
          !result.contains("Sorry");

      if (isValid) {
        if (result != cached) {
          try {
            hiveService.saveLocation(result);
            hiveService.saveDate(DateTime.now());
            emit(LocationSuccess(result, DateTime.now()));
          } catch (e) {
            log("Error saving location: $e");
          }
        }
      } else {
        if (cached.isEmpty) {
          emit(LocationSuccess("Cairo Egypt", DateTime.now()));
        }
      }
    } catch (e) {
      if (cached.isNotEmpty) {
        emit(LocationSuccess(cached, cachedDate));
      } else {
        emit(LocationSuccess("Cairo Egypt", DateTime.now()));
      }
    }
  }
}
