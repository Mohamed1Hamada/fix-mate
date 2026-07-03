part of 'technician_request_cubit.dart';

@immutable
sealed class TechnicianRequestState {}

final class TechnicianRequestInitial extends TechnicianRequestState {}
final class AddTechnicianRequestLoading extends TechnicianRequestState {}
final class AddTechnicianRequestSuccess extends TechnicianRequestState {}
final class AddTechnicianRequestFailed extends TechnicianRequestState {
  final String error;
  AddTechnicianRequestFailed({required this.error});
}
// pick image state
final class PickImageLoading extends TechnicianRequestState {}
final class PickImageSuccess extends TechnicianRequestState {}
final class PickImageFailed extends TechnicianRequestState {
  final String error;
  PickImageFailed({required this.error});
}
final class ImageNotSelected extends TechnicianRequestState {}