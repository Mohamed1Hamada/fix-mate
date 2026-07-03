part of 'customer_requests_cubit.dart';

@immutable
sealed class CustomerRequestsState {}

final class CustomerRequestsInitial extends CustomerRequestsState {}
final class CustomerRequestsLoading extends CustomerRequestsState {}
final class CustomerRequestsSuccess extends CustomerRequestsState {}
final class CustomerRequestsError extends CustomerRequestsState {
  final String message;
  CustomerRequestsError({required this.message});
}
