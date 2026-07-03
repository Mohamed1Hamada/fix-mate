import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/features/customer/ai_chat/models/ai_chat_message_model.dart';
import 'package:fixmate/features/customer/ai_chat/view_models/cubit/maintenance_ai_chat_cubit.dart';
import 'package:fixmate/features/customer/ai_chat/views/widgets/aI_typing_indicator.dart';
import 'package:fixmate/features/customer/ai_chat/views/widgets/ai_chat_input.dart';
import 'package:fixmate/features/customer/ai_chat/views/widgets/ai_message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaintenanceAIChatScreen extends StatefulWidget {
  const MaintenanceAIChatScreen({super.key});

  @override
  State<MaintenanceAIChatScreen> createState() => _MaintenanceAIChatScreenState();
}

class _MaintenanceAIChatScreenState extends State<MaintenanceAIChatScreen> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _typingController;
  late Animation<double> _typingAnimation;

  @override
  void initState() {
    super.initState();
    _typingController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _typingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _typingController, curve: Curves.easeInOut),
    );
    _typingController.repeat();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _typingController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: AppColors.kPrimaryColor,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.kPrimaryColor),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
      ),
      child: BlocProvider(
        create: (_) => MaintenanceAiChatCubit(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'ai_assistant'.tr(),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            backgroundColor: AppColors.kPrimaryColor,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.clear, color: Colors.white),
                onPressed: () {
                  context.read<MaintenanceAiChatCubit>().clearAIChat();
                  _scrollToBottom();
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: BlocConsumer<MaintenanceAiChatCubit, MaintenanceAIChatState>(
                    listener: (context, state) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _scrollToBottom();
                      });
                    },
                    builder: (context, state) {
                      List<AIChatMessage> messages = [];
                      bool isLoading = state is MaintenanceAIChatLoading;
                      if (state is MaintenanceAIChatLoaded) {
                        messages = state.messages;
                      } else if (state is MaintenanceAIChatLoading) {
                        messages = state.messages;
                      }

                      List<AIChatMessage> displayMessages = List.from(messages);
                      if (isLoading) {
                        displayMessages.add(AIChatMessage(
                          text: 'thinking'.tr(),
                          isUser: false,
                          timestamp: DateTime.now(),
                        ));
                      }

                      return ListView.builder(
                        controller: _scrollController,
                        reverse: false,
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        itemCount: displayMessages.length,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final message = displayMessages[index];
                          if (isLoading && index == displayMessages.length - 1) {
                            return AITypingIndicator(animation: _typingAnimation);
                          }
                          return AIMessageBubble(message: message);
                        },
                      );
                    },
                  ),
                ),
                AIChatInput(onScrollToBottom: _scrollToBottom),
              ],
            ),
          ),
        ),
      ),
    );
  }
}