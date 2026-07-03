import 'package:bloc/bloc.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/core/helper/location/get_current_location.dart';
import 'package:fixmate/core/helper/location/location_permission.dart';
import 'package:fixmate/core/network/supabase/database/add_data.dart';
import 'package:fixmate/core/network/supabase/database/get_data.dart';
import 'package:fixmate/features/customer/technician_specialties/models/technician_specialtie_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'complete_technician_profile_state.dart';

class CompleteTechnicianProfileCubit
    extends Cubit<CompleteTechnicianProfileState> {
  CompleteTechnicianProfileCubit() : super(CompleteTechnicianProfileInitial()) {
    getTechnicianSpecialties();
  }

//-- var
  List<TechnicianSpecialtyModel> technicianSpecialties = [];
  TechnicianSpecialtyModel? selectedTechnicianSpecialty;
  Position? position;
  bool? isLocationEnabled = false;
  var supabase = getIt<SupabaseClient>();
//-- fun
  // get technician specialties
  getTechnicianSpecialties() async {
    try {
      emit(GetTechnicianSpecialtiesLoading());
      final response = await getData(tableName: "technician_specialties");
      if (response.isNotEmpty) {
        technicianSpecialties =
            response.map((e) => TechnicianSpecialtyModel.fromJson(e)).toList();
      }
      emit(GetTechnicianSpecialtiesSuccess());
    } catch (e) {
      emit(GetTechnicianSpecialtiesError(message: e.toString()));
    }
  }

  // pick location
  pickLocation() async {
    try {
      emit(GetLocationLoading());
      isLocationEnabled = await requestLocationPermission();
      if (isLocationEnabled == true) {
        position = await getCurrentLocation();
        emit(GetLocationSuccess());
        return;
      } else {
        emit(PermissionNotGranted());
        return;
      }
    } catch (e) {
      emit(GetLocationError(message: e.toString()));
    }
  }

  // pick location from map
  pickLocationFromMap(double latitude, double longitude) async {}
  // complete technician profile
  completeTechnicianProfile() async {
    if (position == null) {
      emit(LocationNotSelected());
      return;
    }
    if (selectedTechnicianSpecialty == null) {
      emit(TechnicianSpecialtyNotSelected());
      return;
    }
    try {
      emit(CompleteTechnicianProfileLoading());
      await addData(tableName: "technicians", data: {
        "id": supabase.auth.currentUser!.id,
        "specialty_id": selectedTechnicianSpecialty!.id,
        "latitude": position!.latitude,
        "longitude": position!.longitude,
      });
      await supabase.from("users").update(
        {"complete_profile": true},
      ).match({"id": supabase.auth.currentUser!.id});
      emit(CompleteTechnicianProfileSuccess());
    } catch (e) {
      emit(CompleteTechnicianProfileError(message: e.toString()));
    }
  }
}
