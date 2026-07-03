part of 'my_chats_cubit.dart';

@immutable
sealed class MyChatsState {}

final class MyChatsInitial extends MyChatsState {}
final class GetMyChatsLoading extends MyChatsState {}
final class GetMyChatsSuccess extends MyChatsState {}
final class GetMyChatsError extends MyChatsState {
  final String error;
  GetMyChatsError({required this.error});
}