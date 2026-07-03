import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/customer/my_chats/views/widgets/customer_header.dart';
import 'package:fixmate/features/customer/my_chats/views/widgets/customer_chats_list_view.dart';
import 'package:fixmate/features/customer/my_chats/views/widgets/customer_chats_search_field.dart';
import 'package:flutter/cupertino.dart';

class MyChatsScreenBody extends StatelessWidget {
  const MyChatsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomHeader(
            title: "chats".tr(),
            icon: CupertinoIcons.chat_bubble_2_fill
          ),
          SizedBox(height: SizeConfig.height * 0.02),
          const MyChatsSearchField(),
          SizedBox(height: SizeConfig.height * 0.02),
          MyChatsListView(),
        ],
      ),
    );
  }
}


