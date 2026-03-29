part of 'location_cubit.dart';

sealed class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final String place;
  final double latitude;
  final double longitude;
  final DateTime date;

  LocationSuccess(this.place, this.latitude, this.longitude, this.date);
}

class LocationFailure extends LocationState {
  final String message;

  LocationFailure(this.message);
}