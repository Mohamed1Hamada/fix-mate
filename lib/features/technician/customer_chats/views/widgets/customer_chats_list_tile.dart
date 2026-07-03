import 'package:fixmate/core/app_route/route_names.dart';
import 'package:fixmate/core/helper/format_time_diffrence.dart';
import 'package:fixmate/core/utilies/extensions/app_extensions.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/features/chat/models/chat_model.dart';
import 'package:flutter/material.dart';

class CustomerChatsListTile extends StatelessWidget {
  final ChatModel chatModel;
  final int index;
  const CustomerChatsListTile({
    super.key,
    required this.chatModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ check آمن للرسائل
    final hasMessages =
        chatModel.messages != null && chatModel.messages!.isNotEmpty;

    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 400 + (index * 50)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      // ✅ Material بدلاً من Container مع elevation للظل
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        elevation: 2,
        shadowColor: Colors.grey.withValues(alpha: 0.4),
        clipBehavior: Clip.antiAlias, // ✅ يقص المحتوى داخل الحواف
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.04,
            vertical: SizeConfig.height * 0.01,
          ),
          leading: CircleAvatar(
            radius: SizeConfig.width * 0.08,
            // ✅ check للـ user والـ image
            backgroundImage: (chatModel.chatWithUser?.image != null &&
                    chatModel.chatWithUser!.image.isNotEmpty)
                ? NetworkImage(chatModel.chatWithUser!.image)
                : null,
            child: (chatModel.chatWithUser?.image == null ||
                    chatModel.chatWithUser!.image.isEmpty)
                ? const Icon(Icons.person, color: Colors.grey)
                : null,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  // ✅ fallback للـ name
                  chatModel.chatWithUser?.fullName ?? 'مستخدم',
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.title16BlackW500,
                ),
              ),
              SizedBox(width: SizeConfig.width * 0.02),
              Text(
                // ✅ check قبل ما يستخدم .last
                hasMessages
                    ? formatTimeDifference(chatModel.messages!.last.createdAt)
                        .toString()
                    : '',
                style: AppTextStyles.title12Grey,
              ),
            ],
          ),
          subtitle: Text(
            // ✅ check قبل ما يستخدم .last
            hasMessages ? chatModel.messages!.last.message : 'لا توجد رسائل',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.title14Grey,
          ),
          onTap: () {
            context.pushScreen(
              RouteNames.chatScreen,
              arguments: chatModel.toJson(),
            );
          },
        ),
      ),
    );
  }
}
