import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/customer/my_chats/view_models/cubit/my_chats_cubit.dart';
import 'package:fixmate/features/customer/my_chats/views/widgets/customer_chats_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyChatsListView extends StatelessWidget {
  const MyChatsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<MyChatsCubit>();
    return BlocBuilder<MyChatsCubit, MyChatsState>(
      builder: (context, state) {
        return Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.04),
            itemCount: cubit.filterMyChats.length,
            separatorBuilder: (_, __) =>
                SizedBox(height: SizeConfig.height * 0.015),
            itemBuilder: (context, index) {
              return MyChatListTile(
                  key: ValueKey(index),
                  chatModel: cubit.filterMyChats[index],
                  index: index);
            },
          ),
        );
      },
    );
  }
}
