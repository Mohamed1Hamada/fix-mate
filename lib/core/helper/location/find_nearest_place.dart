import 'package:fixmate/features/auth/sign_in/models/technician_model.dart';
import 'package:geolocator/geolocator.dart';

Future<List<TechnicianModel>> findNearbyPlaces(
    {required List<TechnicianModel> allPlaces,
    required Position currentLocation}) async {
  List<TechnicianModel> nearbyPlaces = allPlaces.map((place) {
    double distance = Geolocator.distanceBetween(
      currentLocation.latitude,
      currentLocation.longitude,
      (place.latitude),
      (place.longitude),
    );
    return place.copyWith(distance: distance);
  }).toList();
  nearbyPlaces.sort((a, b) => a.distance!.compareTo(b.distance!));
  return nearbyPlaces ;
}
