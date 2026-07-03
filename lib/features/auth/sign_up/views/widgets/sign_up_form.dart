

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixmate/core/components/custom_text_form_field_with_title.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/auth/sign_up/view_models/cubit/sign_up_cubit.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SignUpCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormFieldWithTitle(
          title: "user_name".tr(),
          hintText: "enter_user_name".tr(),
          prefixIcon: CupertinoIcons.person,
          keyboardType: TextInputType.name,
          controller: cubit.userNameController,
        ),
        SizedBox(height: SizeConfig.height * 0.01),
        CustomTextFormFieldWithTitle(
          title: "full_name".tr(),
          hintText: "enter_full_name".tr(),
          prefixIcon: CupertinoIcons.person,
          keyboardType: TextInputType.name,
          controller: cubit.fullNameController,
        ),
        SizedBox(height: SizeConfig.height * 0.01),
        CustomTextFormFieldWithTitle(
          title: "email".tr(),
          hintText: "enter_email".tr(),
          prefixIcon: CupertinoIcons.mail,
          keyboardType: TextInputType.emailAddress,
          controller: cubit.emailController,
        ),
        SizedBox(height: SizeConfig.height * 0.01),
        CustomTextFormFieldWithTitle(
          title: "phone_number".tr(),
          hintText: "enter_phone".tr(),
          prefixIcon: CupertinoIcons.phone,
          keyboardType: TextInputType.phone,
          controller: cubit.phoneController,
        ),
        SizedBox(height: SizeConfig.height * 0.01),
        CustomTextFormFieldWithTitle(
          title: "password".tr(),
          hintText: "enter_password".tr(),
          prefixIcon: CupertinoIcons.padlock,
          isPassword: true,
          keyboardType: TextInputType.visiblePassword,
          controller: cubit.passwordController,
        ),
      ],
    );
  }
}
