// lib/features/chat_maintenance/widgets/ai_assistant_typing_indicator.dart
// Widget for AI assistant typing indicator

import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF06669E);
const Color kBubbleAssistantColor = Color(0xFFF5F5F5);
const Color kTextPrimary = Colors.black87;

class AITypingIndicator extends StatelessWidget {
  final Animation<double> animation;

  const AITypingIndicator({Key? key, required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: kPrimaryColor,
            child: const Icon(Icons.build, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kBubbleAssistantColor,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Thinking...',
                    style: TextStyle(color: kTextPrimary, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...List.generate(
                        3,
                        (index) => AnimatedBuilder(
                          animation: animation,
                          builder: (context, child) {
                            final opacity =
                                (animation.value * 3 - index).clamp(0.0, 1.0);
                            return Transform.translate(
                              offset: Offset(0, (1 - opacity) * 10),
                              child: Container(
                                width: 8,
                                height: 8,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  color:
                                      kPrimaryColor.withValues(alpha: opacity),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
