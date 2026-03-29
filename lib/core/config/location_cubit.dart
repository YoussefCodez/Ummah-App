import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ummah/core/services/get_it_service.dart';
import 'package:ummah/core/services/hive_service.dart';
import 'package:ummah/core/services/location_service.dart';

part 'location_state.dart';

@lazySingleton
class LocationCubit extends Cubit<LocationState> {
  final LocationService _locationService;
  LocationCubit(this._locationService) : super(LocationInitial());

  Future<void> fetchGovernorate() async {
    final hiveService = getIt<HiveService>();
    final cached = hiveService.getLocation();
    final cachedLat = hiveService.getLatitude();
    final cachedLong = hiveService.getLongitude();
    final cachedDate = hiveService.getDate();

    try {
      if (cached.isNotEmpty) {
        emit(LocationSuccess(cached, cachedLat, cachedLong, cachedDate));
      } else {
        emit(LocationLoading());
      }

      final result = await _locationService.getCurrentGovernorate();
      final address = result.address;
      final isValid =
          address.isNotEmpty &&
          !address.contains("Couldn't") &&
          !address.contains("permission") &&
          !address.contains("enable") &&
          !address.contains("denied") &&
          !address.contains("disabled") &&
          !address.contains("Sorry");

      if (isValid) {
        if (address != cached || result.lat != cachedLat || result.long != cachedLong) {
          try {
            hiveService.saveLocation(address);
            hiveService.saveLatitude(result.lat);
            hiveService.saveLongitude(result.long);
            hiveService.saveDate(DateTime.now());
            emit(LocationSuccess(address, result.lat, result.long, DateTime.now()));
          } catch (e) {
            log("Error saving location: $e");
          }
        }
      } else {
        if (cached.isEmpty) {
          emit(LocationSuccess("Cairo Egypt", 30.0444, 31.2357, DateTime.now()));
        }
      }
    } catch (e) {
      if (cached.isNotEmpty) {
        emit(LocationSuccess(cached, cachedLat, cachedLong, cachedDate));
      } else {
        emit(LocationSuccess("Cairo Egypt", 30.0444, 31.2357, DateTime.now()));
      }
    }
  }
}
