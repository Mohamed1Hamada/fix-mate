import 'package:easy_localization/easy_localization.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:fixmate/core/components/custom_text_form_field.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/technician/customer_chats/view_models/cubit/my_chats_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerChatsSearchField extends StatelessWidget {
  const CustomerChatsSearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.04),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: CustomTextFormField(
          hintText: "search_chats".tr(),
          prefixIcon: CupertinoIcons.search,
          onChanged: (value) => EasyDebounce.debounce(
            'customer_chats_search',
            const Duration(milliseconds: 400),
            () {
              context.read<CustomerChatsCubit>().searchChats(value);
            },
          ),
        ),
      ),
    );
  }
}
