part of 'my_chats_cubit.dart';

@immutable
sealed class CustomerChatsState {}

final class CustomerChatsInitial extends CustomerChatsState {}
final class GetCustomerChatsLoading extends CustomerChatsState {}
final class GetCustomerChatsSuccess extends CustomerChatsState {}
final class GetCustomerChatsError extends CustomerChatsState {
  final String error;
  GetCustomerChatsError({required this.error});
}