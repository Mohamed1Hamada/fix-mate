import 'package:fixmate/features/auth/sign_in/models/user_model.dart';
import 'package:fixmate/features/chat/models/message_model.dart';
import 'package:uuid/uuid.dart';

class ChatModel {
  final String? id;
  final String customerId;
  final String technicianId;
  final UserModel? chatWithUser;
  final List<ChatMessage>? messages;
  ChatModel({
    this.id,
    required this.customerId,
    required this.technicianId,
    this.messages,
    this.chatWithUser,
  });
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] ?? Uuid().v4(),
      customerId: json['customer_id'],
      technicianId: json['technician_id'],
      chatWithUser: json['chatWithUser'] != null
          ? UserModel.fromJson(json['chatWithUser'])
          : null,
      messages: json['messages'] != null
          ? List<ChatMessage>.from(
              json['messages'].map((x) => ChatMessage.fromJson(x)))
          : [],
    );
  }
  toJson() => {
        'id': id,
        'customer_id': customerId,
        'technician_id': technicianId,
        'messages': messages?.map((x) => x.toJson()).toList(),
        'chat_with_user': chatWithUser?.toJson(),
      };
}
