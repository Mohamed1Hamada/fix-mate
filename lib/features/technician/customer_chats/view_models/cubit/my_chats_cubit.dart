import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/features/chat/models/chat_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'my_chats_state.dart';

class CustomerChatsCubit extends Cubit<CustomerChatsState> {
  CustomerChatsCubit() : super(CustomerChatsInitial()) {
    getCustomerChats();
  }
// --> list of my chats
  List<ChatModel> myChats = [];
  List<ChatModel> filterCustomerChats = [];
  final supabase = getIt<SupabaseClient>();
// --> get my chats
  getCustomerChats() async {
    try {
      log("cahst");
      if (isClosed) return; // ✅
      emit(GetCustomerChatsLoading());
      final response = await supabase
          .from('chats')
          .select(
              '*, chatWithUser:users!fk_chats_customer(id, full_name, username, image)')
          .eq('technician_id', getIt<SupabaseClient>().auth.currentUser!.id);

      myChats = response
          .map((e) => ChatModel.fromJson(e))
          .where((chat) =>
              chat.messages != null &&
              chat.messages!.isNotEmpty) // ✅ شيل المحادثات الفاضية
          .toList();

      // ✅ sort آمن
      myChats.sort((a, b) {
        final aDate = (a.messages?.isNotEmpty ?? false)
            ? a.messages!.last.createdAt
            : DateTime(2000);
        final bDate = (b.messages?.isNotEmpty ?? false)
            ? b.messages!.last.createdAt
            : DateTime(2000);
        return bDate.compareTo(aDate);
      });

      filterCustomerChats = myChats;

      if (isClosed) return; // ✅
      emit(GetCustomerChatsSuccess());
    } catch (e) {
      log(e.toString());
      if (isClosed) return; // ✅
      emit(GetCustomerChatsError(error: e.toString()));
    }
  }

// --> search for chats
  void searchChats(String value) {
    if (value.isEmpty) {
      filterCustomerChats = myChats;
    } else {
      filterCustomerChats = myChats.where((element) {
        // ✅ check قبل ما يستخدم .last
        if (element.messages == null || element.messages!.isEmpty) {
          return false;
        }
        return element.messages!.last.message
            .toLowerCase()
            .contains(value.toLowerCase());
      }).toList();
    }
    if (isClosed) return; // ✅
    emit(GetCustomerChatsSuccess());
  }
}
