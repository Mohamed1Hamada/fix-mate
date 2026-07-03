part of 'my_requests_cubit.dart';

@immutable
sealed class MyRequestsState {}

final class MyRequestsInitial extends MyRequestsState {}
final class GetMyRequestsLoading extends MyRequestsState {}
final class GetMyRequestsSuccess extends MyRequestsState {}
final class GetMyRequestsError extends MyRequestsState {
  final String message;
  GetMyRequestsError({required this.message});
}