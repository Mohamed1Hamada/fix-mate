import 'package:fixmate/features/chat/models/chat_model.dart';
import 'package:fixmate/features/chat/view_models/cubit/chat_cubit.dart';
import 'package:fixmate/features/chat/views/widgets/chat_header.dart';
import 'package:fixmate/features/chat/views/widgets/messages_list_view.dart';
import 'package:fixmate/features/chat/views/widgets/send_message.dart';
import 'package:fixmate/features/customer/nearest_technicians/views/widgets/custom_failure_message.dart';
import 'package:fixmate/features/customer/nearest_technicians/views/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreenBody extends StatelessWidget {
  const ChatScreenBody({
    super.key,
    required this.chatModel,
  });

  final ChatModel chatModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              final cubit = context.read<ChatCubit>();
              if (state is ChatLoading) {
                return CustomLoadingIndicator();
              }
              if (state is ChatFailed) {
                return CustomFailureMesage(errorMessage: state.error);
              }
              if (state is ChatLoaded) {
                return Column(
                  children: [
                    ChatHeader(chatModel: chatModel),
                    MessagesListView(
                      messages: state.messages,
                    ),
                    SendMessage(cubit: cubit),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
