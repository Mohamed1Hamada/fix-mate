import 'dart:io';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:fixmate/features/customer/ai_chat/models/ai_chat_message_model.dart';
import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF06669E);
const Color kSecondaryColor = Color(0xFF1E88E5);
const Color kBubbleUserColor = Color(0xFF06669E);
const Color kBubbleAssistantColor = Color(0xFFF5F5F5);
const Color kTextPrimary = Colors.black87;

class AIMessageBubble extends StatelessWidget {
  final AIChatMessage message;

  const AIMessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final imageFile = message.imagePath != null ? File(message.imagePath!) : null;
    if (message.text.trim().isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 20,
              backgroundColor: kPrimaryColor,
              child: const Icon(Icons.build, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (imageFile != null && imageFile.existsSync())
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      imageFile,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Icon(Icons.error, color: Colors.grey),
                      ),
                    ),
                  ),
                if (imageFile != null) const SizedBox(height: 4),
                BubbleSpecialThree(
                  text: message.text,
                  color: isUser ? kBubbleUserColor : kBubbleAssistantColor,
                  tail: isUser ? true : true,
                  isSender: isUser,
                  textStyle: TextStyle(
                    color: isUser ? Colors.white : kTextPrimary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${message.timestamp.hour.toString().padLeft(2, '0')}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 20,
              backgroundColor: kSecondaryColor,
              child: const Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ],
        ],
      ),
    );
  }
}