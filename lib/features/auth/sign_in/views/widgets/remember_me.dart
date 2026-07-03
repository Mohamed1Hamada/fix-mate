import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fixmate/core/components/custom_text_button.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';

class RememberMeAndForgotPassword extends StatelessWidget {
  const RememberMeAndForgotPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: false,
          fillColor: WidgetStateProperty.all(AppColors.kBackgroundColor),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: AppColors.kPrimaryColor)),
          activeColor: AppColors.kPrimaryColor,
          checkColor: AppColors.kPrimaryColor,
          onChanged: (value) {
            // context.read<SignInCubit>().changeRememberMe();
          },
        ),
        Text(
          "remember_me".tr(),
          style: AppTextStyles.title16Black,
        ),
        const Spacer(),
        CustomTextButton(
          title: "forgot_password".tr(),
          style: AppTextStyles.title18kPrimaryColorBold,
        ),
      ],
    );
  }
}
