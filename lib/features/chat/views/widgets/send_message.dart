import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/components/custom_icon_button.dart';
import 'package:fixmate/core/components/custom_text_form_field.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/features/chat/view_models/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';

class SendMessage extends StatelessWidget {
  const SendMessage({super.key, required this.cubit});
  final ChatCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      height: SizeConfig.height * 0.1,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * 0.03,
          vertical: SizeConfig.height * 0.01,
        ),
        child: Row(
          spacing: SizeConfig.width * 0.01,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    fillColor: AppColors.kPrimaryColor.withValues(alpha: 0.5),
                    controller: cubit.messageController,
                    hintText: "enter_message".tr(),
                    hintStyle: AppTextStyles.title16White400,
                    style: AppTextStyles.title18White,
                  ),
                ],
              ),
            ),
            SizedBox(width: SizeConfig.width * 0.01),
            CustomIconButton(
              backgroundColor: AppColors.kPrimaryColor,
              icon: Icon(Icons.send),
              iconColor: Colors.white,
              onPressed: () {
                cubit.addMessage(text: cubit.messageController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
