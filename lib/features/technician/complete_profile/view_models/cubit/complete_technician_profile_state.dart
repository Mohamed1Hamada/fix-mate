part of 'complete_technician_profile_cubit.dart';

@immutable
sealed class CompleteTechnicianProfileState {}

final class CompleteTechnicianProfileInitial
    extends CompleteTechnicianProfileState {}

// getTechnicianSpecialties
final class GetTechnicianSpecialtiesLoading
    extends CompleteTechnicianProfileState {}

final class GetTechnicianSpecialtiesSuccess
    extends CompleteTechnicianProfileState {}

final class GetTechnicianSpecialtiesError
    extends CompleteTechnicianProfileState {
  final String message;
  GetTechnicianSpecialtiesError({required this.message});
}

// completeTechnicianProfile
final class CompleteTechnicianProfileLoading
    extends CompleteTechnicianProfileState {}

final class CompleteTechnicianProfileSuccess
    extends CompleteTechnicianProfileState {}

final class CompleteTechnicianProfileError
    extends CompleteTechnicianProfileState {
  final String message;
  CompleteTechnicianProfileError({required this.message});
}

//
final class TechnicianSpecialtyNotSelected
    extends CompleteTechnicianProfileState {}

//
final class LocationNotSelected extends CompleteTechnicianProfileState {}
//
final class PermissionNotGranted extends CompleteTechnicianProfileState {}
//
final class GetLocationLoading extends CompleteTechnicianProfileState {}

//
final class GetLocationSuccess extends CompleteTechnicianProfileState {}

//
final class GetLocationError extends CompleteTechnicianProfileState {
  final String message;
  GetLocationError({required this.message});
}
