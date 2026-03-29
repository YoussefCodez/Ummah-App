import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class LocationService {
  Future<({String address, double lat, double long})> getCurrentGovernorate() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Please enable location services';
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permission denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permission permanently denied. Please enable it in settings.';
    }

    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.medium),
      );
    } catch (e) {
      print('Geocoding error: $e');
      throw "Couldn't get your location. Please try again.";
    }

    try {
      await setLocaleIdentifier('en_US');

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) {
        return (address: 'Unknown', lat: position.latitude, long: position.longitude);
      }

      Placemark place = placemarks.first;

      String country = place.country ?? 'Unknown Country';
      String governorate =
          place.administrativeArea ??
          place.subAdministrativeArea ??
          place.locality ??
          place.subLocality ??
          'Unknown';
      governorate = governorate
          .replaceAll(
            RegExp(
              r'\s*(Governorate|Governorate of|of)\s*',
              caseSensitive: false,
            ),
            '',
          )
          .replaceAll('Muhafazah', '')
          .trim();
      return (
        address: '$governorate, $country',
        lat: position.latitude,
        long: position.longitude,
      );
    } catch (e) {
      // ignore: avoid_print
      print('Geocoding error: $e');
      return (
        address: 'Unknown',
        lat: position.latitude,
        long: position.longitude,
      );
    }
  }
}
