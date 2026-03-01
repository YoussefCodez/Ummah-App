part of 'location_cubit.dart';

sealed class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final String place;
  final DateTime date;

  LocationSuccess(this.place, this.date);
}

class LocationFailure extends LocationState {
  final String message;

  LocationFailure(this.message);
}