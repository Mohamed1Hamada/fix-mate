import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/core/helper/location/find_nearest_place.dart';
import 'package:fixmate/core/helper/location/get_current_location.dart';
import 'package:fixmate/core/helper/location/location_cache.dart';
import 'package:fixmate/core/helper/location/location_permission.dart';
import 'package:fixmate/features/auth/sign_in/models/technician_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'nearest_technicians_state.dart';

class NearestTechniciansCubit extends Cubit<NearestTechniciansState> {
  NearestTechniciansCubit() : super(NearestTechniciansInitial());
  Position? currentLocation;
  final supabase = getIt<SupabaseClient>();
  List<TechnicianModel> technicians = [];
  List<TechnicianModel> nearestTechnicians = [];
  getTechnicians({required String technicianSpecialtyId}) async {
    try {
      emit(GetNearestTechniciansLoading());
      final response = await supabase
          .from('technicians')
          .select(
              'id, specialty_id, latitude, longitude, rating, is_available, users(full_name, image, phone_number, email, tokens)')
          .eq('specialty_id', technicianSpecialtyId);
      log(response.toString());
      technicians = response.map((e) => TechnicianModel.fromJson(e)).toList();
      technicians.map((e) => log(e.toJson().toString())).toList();
      await getNearestTechnicians();
      emit(GetNearestTechniciansSuccess());
    } catch (e) {
      emit(GetNearestTechniciansError(
        message: e.toString(),
      ));
    }
  }

  bool locationPermission = false;
  getNearestTechnicians() async {
    try {
      locationPermission = await requestLocationPermission();
      if (locationPermission == true) {
        currentLocation = await getCurrentLocation();
        LocationCache()
            .setLocation(currentLocation!.latitude, currentLocation!.longitude);
        final response = await findNearbyPlaces(
            allPlaces: technicians, currentLocation: currentLocation!);
        technicians.clear();
        technicians = response;
        nearestTechnicians = response;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // search technicians
  searchTechnicians(String query) {
    if (query.isEmpty) {
      nearestTechnicians = technicians;
    } else {
      nearestTechnicians = technicians
          .where((tech) =>
              tech.fullName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    emit(GetNearestTechniciansSuccess());
  }
}
