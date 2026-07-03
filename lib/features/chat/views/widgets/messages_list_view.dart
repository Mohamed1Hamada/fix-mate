import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:fixmate/core/cache/cache_helper.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/features/chat/models/message_model.dart';
import 'package:flutter/material.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView({super.key, required this.messages});
  final List<ChatMessage> messages;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(
          top: SizeConfig.height * 0.02,
          bottom: SizeConfig.height * 0.01,
          left: SizeConfig.width * 0.01,
          right: SizeConfig.width * 0.01,
        ),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          bool isSender = messages[index].id ==
              getIt<CacheHelper>().getUserModel()!.id.toString();
          return BubbleSpecialThree(
            key: ValueKey(messages[index].id),
            isSender: messages[index].id ==
                getIt<CacheHelper>().getUserModel()!.id.toString(),
            text: messages[index].message,
            color: isSender ? AppColors.kPrimaryColor
                : Colors.grey.shade300,
            tail: true,
            textStyle: isSender ? AppTextStyles.title18White
                : AppTextStyles.title18PrimaryColorW500,
          );
        },
      ),
    );
  }
}
