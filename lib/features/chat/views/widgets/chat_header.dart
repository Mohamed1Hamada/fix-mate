import 'package:fixmate/features/chat/view_models/cubit/chat_cubit.dart';
import 'package:fixmate/features/customer/my_chats/views/widgets/customer_header.dart';
import 'package:flutter/material.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/features/chat/models/chat_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({
    super.key,
    required this.chatModel,
  });
  final ChatModel chatModel;
  @override
  Widget build(BuildContext context) {
    var userModel = context.read<ChatCubit>().chatUserModel;
    return CustomHeader(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: SizeConfig.width * 0.07,
            backgroundImage: NetworkImage(userModel!.image),
          ),
          SizedBox(width: SizeConfig.width * 0.04),
          Text(
            userModel.fullName,
            style: AppTextStyles.title20WhiteW500,
          ),
        ],
      ),
    );
  }
}
