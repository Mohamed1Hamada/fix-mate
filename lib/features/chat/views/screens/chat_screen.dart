import 'dart:developer';

import 'package:fixmate/features/chat/models/chat_model.dart';
import 'package:fixmate/features/chat/view_models/cubit/chat_cubit.dart';
import 'package:fixmate/features/chat/views/widgets/chat_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    log("arguments");
    log("--------------------"+arguments.toString());
    var chatModel = ChatModel.fromJson(arguments);
    return BlocProvider(
      create: (context) => ChatCubit(chatModel: chatModel),
      child: Scaffold(
        body: ChatScreenBody(chatModel: chatModel),
      ),
    );
  }
}
