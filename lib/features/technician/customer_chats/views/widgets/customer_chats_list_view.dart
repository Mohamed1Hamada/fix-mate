import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/technician/customer_chats/view_models/cubit/my_chats_cubit.dart';
import 'package:fixmate/features/technician/customer_chats/views/widgets/customer_chats_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerChatsListView extends StatelessWidget {
  const CustomerChatsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CustomerChatsCubit>();
    return BlocBuilder<CustomerChatsCubit, CustomerChatsState>(
      builder: (context, state) {
        return Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.04),
            itemCount: cubit.filterCustomerChats.length,
            separatorBuilder: (_, __) =>
                SizedBox(height: SizeConfig.height * 0.015),
            itemBuilder: (context, index) {
              return CustomerChatsListTile(
                  key: ValueKey(index),
                  chatModel: cubit.filterCustomerChats[index],
                  index: index);
            },
          ),
        );
      },
    );
  }
}
