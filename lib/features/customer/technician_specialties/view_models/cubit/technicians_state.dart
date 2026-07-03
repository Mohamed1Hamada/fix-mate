part of 'technicians_cubit.dart';

@immutable
sealed class TechniciansState {}

final class TechniciansInitial extends TechniciansState {}

class TechnicianInitial extends TechniciansState {}

class GetTechnicianSpecialtiesLoading extends TechniciansState {}

class GetTechnicianSpecialtiesSuccess extends TechniciansState {}

class GetTechnicianSpecialtiesError extends TechniciansState {
  final String message;
  GetTechnicianSpecialtiesError(this.message);
}

class TechnicianSelected extends TechniciansState {}

