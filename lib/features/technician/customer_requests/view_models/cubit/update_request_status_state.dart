part of 'update_request_status_cubit.dart';

@immutable
sealed class UpdateRequestStatusState {}

final class UpdateRequestStatusInitial extends UpdateRequestStatusState {}
// update status
final class UpdateRequestStatusLoading extends UpdateRequestStatusState {}
final class UpdateRequestStatusSuccess extends UpdateRequestStatusState {}
final class UpdateRequestStatusError extends UpdateRequestStatusState {
  final String message;
  UpdateRequestStatusError({required this.message});
}
final class UpdateSelectedStatus extends UpdateRequestStatusState {}