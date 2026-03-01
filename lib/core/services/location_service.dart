import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';


@LazySingleton()
class LocationService {
  Future<String> getCurrentGovernorate() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 'Please enable location services';
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'Location permission denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return 'Location permission permanently denied. Please enable it in settings.';
    }

    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.medium),
      );
    } catch (e) {
      print('Geocoding error: $e');
      return "Couldn't get your location. Please try again.";
    }

    try {
      await setLocaleIdentifier('en_US');

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) {
        return 'No location information found';
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
      return '$governorate, $country';
    } catch (e) {
      print('Geocoding error: $e'); 
      return "Couldn't fetch address information";
    }
  }
}
