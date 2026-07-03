import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/features/chat/models/chat_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'my_chats_state.dart';

class MyChatsCubit extends Cubit<MyChatsState> {
  MyChatsCubit() : super(MyChatsInitial()) {
    getMyChats();
  }
// --> list of my chats
  List<ChatModel> myChats = [];
  List<ChatModel> filterMyChats = [];
  final supabase = getIt<SupabaseClient>();
// --> get my chats
  getMyChats() async {
    try {
      log("cahst");
      if (isClosed) return; // ✅
      emit(GetMyChatsLoading());
      final response = await supabase
          .from('chats')
          .select(
              '*, chatWithUser:users!fk_chats_technician(id, full_name, username, image)')
          .eq('customer_id', getIt<SupabaseClient>().auth.currentUser!.id);
      log("cahst" + response.toString());

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

      filterMyChats = myChats;

      if (isClosed) return; // ✅
      emit(GetMyChatsSuccess());
    } catch (e) {
      log(e.toString());
      if (isClosed) return; // ✅
      emit(GetMyChatsError(error: e.toString()));
    }
  }

// --> search for chats
  void searchChats(String value) {
    if (value.isEmpty) {
      filterMyChats = myChats;
    } else {
      filterMyChats = myChats.where((element) {
        // ✅ check قبل .last
        if (element.messages == null || element.messages!.isEmpty) {
          return false;
        }
        return element.messages!.last.message
            .toLowerCase()
            .contains(value.toLowerCase());
      }).toList();
    }
    if (isClosed) return; // ✅
    emit(GetMyChatsSuccess());
  }
}
