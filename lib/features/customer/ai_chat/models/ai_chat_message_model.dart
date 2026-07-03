import 'package:meta/meta.dart';

@immutable
class AIChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final String? imagePath;

  const AIChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.imagePath,
  });

  AIChatMessage copyWith({
    String? text,
    bool? isUser,
    DateTime? timestamp,
    String? imagePath,
  }) {
    return AIChatMessage(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      timestamp: timestamp ?? this.timestamp,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isUser': isUser,
      'timestamp': timestamp.toIso8601String(),
      'imagePath': imagePath,
    };
  }

  factory AIChatMessage.fromJson(Map<String, dynamic> json) {
    return AIChatMessage(
      text: json['text'] as String,
      isUser: json['isUser'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
      imagePath: json['imagePath'] as String?,
    );
  }
}