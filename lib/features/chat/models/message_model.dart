class ChatMessage {
  final String message;
  final String id;
  final DateTime createdAt;
  ChatMessage({required this.message, required this.id,required this.createdAt});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      message: json["message"],
      id: json["id"],
      createdAt: DateTime.parse(json["created_at"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "id": id,
      "created_at": createdAt.toIso8601String(),
    };
  }}
