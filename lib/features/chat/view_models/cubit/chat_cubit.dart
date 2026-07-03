import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:fixmate/core/cache/cache_helper.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/core/network/supabase/database/get_data_with_spacific_id.dart';
import 'package:fixmate/core/network/supabase/database/stream_data_with_spacific.dart';
import 'package:fixmate/features/auth/sign_in/models/user_model.dart';
import 'package:fixmate/features/chat/models/chat_model.dart';
import 'package:fixmate/features/chat/models/message_model.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.chatModel}) : super(ChatLoading()) {
    _initializeChat().then((_) => _loadMessages());
  }

  final ChatModel chatModel;
  UserModel? chatUserModel;
  StreamSubscription? _streamSubscription;
  final supabase = getIt<SupabaseClient>();
  final messageController = TextEditingController();
  Future<void> _initializeChat() async {
    try {
      if (chatModel.customerId == getIt<CacheHelper>().getUserModel()!.id) {
        final response = await getDataWithSpacificId(
          tableName: "users",
          id: chatModel.technicianId,
        );
        chatUserModel = UserModel.fromJson(response.first);
      }else{
        final response = await getDataWithSpacificId(
          tableName: "users",
          id: chatModel.customerId,
        );
        chatUserModel = UserModel.fromJson(response.first);
      }
      final existing = await supabase
          .from("chats")
          .select("id")
          .eq("id", chatModel.id!)
          .maybeSingle();
      if (existing == null) {
        await supabase.from("chats").insert({
          "id": chatModel.id,
          "customer_id": chatModel.customerId,
          "technician_id": chatModel.technicianId,
        });
      } else {
        log("✅ Chat with id '$chatModel.id' already exists.");
      }
    } catch (e, stack) {
      log("❌ Error initializing chat: $e");
      log("🪜 Stack trace: $stack");
    }
  }

  void _loadMessages() {
    try {
      _streamSubscription = streamDataWithSpecificId(
        tableName: "chats",
        id: chatModel.id!,
        primaryKey: 'id',
      ).listen(
        (data) {
          if (data.isNotEmpty) {
            final dynamic messagesData = data[0]['messages'];
            final List<dynamic> messagesJson =
                (messagesData is List) ? messagesData : [];
            final List<ChatMessage> messages =
                messagesJson.map((json) => ChatMessage.fromJson(json)).toList();
            emit(ChatLoaded(messages: messages));
          } else {
            emit(ChatLoaded(messages: []));
          }
        },
        onError: (error) {
          log(error.toString());
        },
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> addMessage({required String text}) async {
    try {
      if (messageController.text.isNotEmpty) {
        log("📥 Starting to add message...");

        try {
          final chatData = await supabase
              .from("chats")
              .select("messages")
              .eq("id", chatModel.id!)
              .single();
          final dynamic messagesData = chatData['messages'];
          final List<dynamic> messagesJson =
              (messagesData is List) ? messagesData : [];
          final List<ChatMessage> messages =
              messagesJson.map((json) => ChatMessage.fromJson(json)).toList();
          final newMessage = ChatMessage(
            message: text,
            id: getIt<CacheHelper>().getUserModel()!.id.toString(),
            createdAt: DateTime.now(),
          );
          messages.add(newMessage);
          await supabase.from("chats").update({
            "messages": messages.map((m) => m.toJson()).toList()
          }).eq("id", chatModel.id!);
          messageController.clear();
        } catch (e) {
          emit(ChatFailed(error: e.toString()));
        }
      } else {}
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
