import 'package:bloc/bloc.dart';
import 'package:fixmate/core/network/supabase/database/get_data.dart';
import 'package:fixmate/features/customer/technician_specialties/models/technician_specialtie_model.dart';
import 'package:meta/meta.dart';
part 'technicians_state.dart';

class TechniciansCubit extends Cubit<TechniciansState> {
  TechniciansCubit() : super(TechniciansInitial()) {
    getTechnicianSpecialties();
  }

  List<TechnicianSpecialtyModel> allTechnicians = [];
  List<TechnicianSpecialtyModel> filteredTechnicians = [];
  TechnicianSpecialtyModel? selectedTechnicianSpecialty;

  // get technician specialties
  getTechnicianSpecialties() async {
    try {
      emit(GetTechnicianSpecialtiesLoading());
      final response = await getData(tableName: "technician_specialties");
      allTechnicians =
          response.map((e) => TechnicianSpecialtyModel.fromJson(e)).toList();
      filteredTechnicians = allTechnicians;
      emit(GetTechnicianSpecialtiesSuccess());
    } catch (e) {}
  }

  // select technician
  void selectTechnician(TechnicianSpecialtyModel tech) {
    selectedTechnicianSpecialty = tech;
    emit(TechnicianSelected());
  }

  // search technicians
  void searchTechnicians(String query) {
    if (query.isEmpty) {
      filteredTechnicians = allTechnicians;
    } else {
      filteredTechnicians = allTechnicians
          .where(
              (tech) => tech.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    emit(GetTechnicianSpecialtiesSuccess());
  }
}
