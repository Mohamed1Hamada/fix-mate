

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixmate/core/components/custom_text_form_field_with_title.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/auth/sign_in/view_models/cubit/sign_in_cubit.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SignInCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          CustomTextFormFieldWithTitle(
            title: "email".tr(),
            hintText: "enter_email".tr(),
            prefixIcon: CupertinoIcons.phone,
            controller: cubit.emailController,
          ),
          SizedBox(height: SizeConfig.height * 0.01),
          CustomTextFormFieldWithTitle(
            title: "password".tr(),
            hintText: "enter_password".tr(),
            controller: cubit.passwordController,
            prefixIcon: CupertinoIcons.padlock,
            isPassword: true,
          ),
          SizedBox(height: SizeConfig.height * 0.01),
        ],
      ),
    );
  }
}
