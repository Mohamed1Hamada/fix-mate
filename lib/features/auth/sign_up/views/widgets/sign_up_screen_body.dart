import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/features/auth/sign_in/views/widgets/or_sign_with.dart';
import 'package:custom_quick_alert/custom_quick_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixmate/core/components/custom_elevated_button.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/extensions/app_extensions.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/auth/sign_in/views/widgets/have_account_or_not.dart';
import 'package:fixmate/features/auth/sign_up/view_models/cubit/sign_up_cubit.dart';
import 'package:fixmate/features/auth/sign_up/views/widgets/pick_image.dart';
import 'package:fixmate/features/auth/sign_up/views/widgets/sign_up_form.dart';
import 'package:fixmate/features/auth/sign_up/views/widgets/social_sign_up.dart';

class SignUpScreenBody extends StatelessWidget {
  const SignUpScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.03,
        vertical: SizeConfig.height * 0.01,
      ),
      child: Center(
        child: SingleChildScrollView(
          child: BlocListener<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state is SignUpSuccess || state is SignUpWithGoogleSuccess) {
                context.popScreen();
                CustomQuickAlert.success(
                  title: 'success'.tr(),
                  message: 'sign_up_success'.tr(),
                  animationType: CustomQuickAlertAnimationType.scale,
                );
              }
              if (state is SignUpWithGoogleFailure) {
                CustomQuickAlert.error(
                  title:  'error'.tr(),
                  message: state.errorMessage,
                  animationType: CustomQuickAlertAnimationType.slideInDown,
                );
              }
              if (state is SignUpFailure) {
                CustomQuickAlert.error(
                  title: 'error'.tr(),
                  message: state.errorMessage,
                  animationType: CustomQuickAlertAnimationType.slideInDown,
                );
              }
              if (state is PickImageFailure) {
                CustomQuickAlert.info(
                  title:  'info'.tr(),
                  message: state.errorMessage,
                  animationType: CustomQuickAlertAnimationType.slideInDown,
                );
              }
            },
            child: Form(
              key: context.read<SignUpCubit>().formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: SizeConfig.height * 0.01),
                  const PickImage(),
                  SizedBox(height: SizeConfig.height * 0.04),
                  const SignUpForm(),
                  SizedBox(height: SizeConfig.height * 0.04),
                  BlocBuilder<SignUpCubit, SignUpState>(
                    buildWhen: (previous, current) =>
                        current is SignUpLoading || previous is SignUpLoading,
                    builder: (context, state) {
                      return state is SignUpLoading
                          ? CircularProgressIndicator(
                              color: AppColors.kPrimaryColor,
                            )
                          : CustomElevatedButton(
                              width: SizeConfig.width * 0.9,
                              hPadding: SizeConfig.width * 0.03,
                              name:  "sign_up".tr(),
                              onPressed: () {
                                cubit.signUp();
                              },
                              backgroundColor: AppColors.kPrimaryColor,
                            );
                    },
                  ),
                  const OrSignWith(),
                  const SocialSingUp(),
                  SizedBox(height: SizeConfig.height * 0.02),
                  HaveAccountOrNot(
                    title:  "have_account".tr(),
                    value: "sign_in".tr(),
                    onPressed: () {
                      context.popScreen();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
