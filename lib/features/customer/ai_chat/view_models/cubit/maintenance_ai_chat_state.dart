part of 'maintenance_ai_chat_cubit.dart';

@immutable
abstract class MaintenanceAIChatState {
  const MaintenanceAIChatState();
}

class MaintenanceAIChatInitial extends MaintenanceAIChatState {
  const MaintenanceAIChatInitial();
}

class MaintenanceAIChatLoading extends MaintenanceAIChatState {
  final List<AIChatMessage> messages;
  const MaintenanceAIChatLoading(this.messages);
}

class MaintenanceAIChatLoaded extends MaintenanceAIChatState {
  final List<AIChatMessage> messages;
  const MaintenanceAIChatLoaded(this.messages);
}