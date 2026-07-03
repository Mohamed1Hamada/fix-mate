import 'package:fixmate/core/helper/location/location_permission.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation() async {
  bool serviceEnabled = await requestLocationPermission();
  if (serviceEnabled) {
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
    return position;
  } else {
    throw Exception('Location services are disabled.');
  }
}
