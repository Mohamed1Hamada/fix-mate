part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatLoaded extends ChatState {
  final List<ChatMessage> messages;

  ChatLoaded({required this.messages});
}

final class ChatFailed extends ChatState {
  final String error;

  ChatFailed({required this.error});
}
