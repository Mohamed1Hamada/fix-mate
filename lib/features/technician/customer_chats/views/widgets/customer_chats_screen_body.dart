import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/customer/my_chats/views/widgets/customer_header.dart';
import 'package:fixmate/features/technician/customer_chats/views/widgets/customer_chats_list_view.dart';
import 'package:fixmate/features/technician/customer_chats/views/widgets/customer_chats_search_field.dart';
import 'package:flutter/cupertino.dart';

class CustomerChatsScreenBody extends StatelessWidget {
  const CustomerChatsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomHeader(
            title:"Chats",
            icon:CupertinoIcons.chat_bubble_2_fill
          ),
          SizedBox(height: SizeConfig.height * 0.02),
          const CustomerChatsSearchField(),
          SizedBox(height: SizeConfig.height * 0.02),
          CustomerChatsListView(),
        ],
      ),
    );
  }
}


