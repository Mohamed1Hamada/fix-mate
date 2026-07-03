import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/components/custom_circular_progress_indecator.dart';
import 'package:fixmate/features/auth/sign_in/views/widgets/or_sign_with.dart';
import 'package:custom_quick_alert/custom_quick_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixmate/core/app_route/route_names.dart';
import 'package:fixmate/core/components/custom_elevated_button.dart';
import 'package:fixmate/core/utilies/assets/images/app_images.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/extensions/app_extensions.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/auth/sign_in/view_models/cubit/sign_in_cubit.dart';
import 'package:fixmate/features/auth/sign_in/views/widgets/have_account_or_not.dart';
import 'package:fixmate/features/auth/sign_in/views/widgets/remember_me.dart';
import 'package:fixmate/features/auth/sign_in/views/widgets/sign_in_form.dart';
import 'package:fixmate/features/auth/sign_in/views/widgets/social_sign_in.dart';

class SignInScreenBody extends StatelessWidget {
  const SignInScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * 0.03,
          vertical: SizeConfig.height * 0.01,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  AppImages.logoImage,
                  width: SizeConfig.width * 0.6,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: SizeConfig.height * 0.06),
                BlocListener<SignInCubit, SignInState>(
                  listener: (context, state) {
                    if (state is SignInSuccess) {
                      context.pushReplacementScreen(
                        state.route,
                      );
                      CustomQuickAlert.success(
                        title: 'success'.tr(),
                        message: 'sign_in_success'.tr(),
                        animationType: CustomQuickAlertAnimationType.scale,
                      );
                    }
                    if (state is SignInWithGoogleSuccess) {
                      context.pushReplacementScreen(
                        state.route,
                      );
                      CustomQuickAlert.success(
                        title: 'success'.tr(),
                        message: 'sign_in_success'.tr(),
                        animationType: CustomQuickAlertAnimationType.scale,
                      );
                    }
                    if (state is SignInFailure) {
                      CustomQuickAlert.error(
                        title: 'error'.tr(),
                        message: state.message,
                        animationType:
                            CustomQuickAlertAnimationType.slideInDown,
                      );
                    } else if (state is SignInWithGoogleFailure) {
                      CustomQuickAlert.error(
                        title: 'error'.tr(),
                        message: state.message,
                        animationType:
                            CustomQuickAlertAnimationType.slideInDown,
                      );
                    }
                  },
                  child: const SignInForm(),
                ),
                const RememberMeAndForgotPassword(),
                SizedBox(height: SizeConfig.height * 0.05),
                BlocBuilder<SignInCubit, SignInState>(
                  buildWhen: (previous, current) =>
                      current is SignInLoading || previous is SignInLoading,
                  builder: (context, state) {
                    return state is SignInLoading
                        ? const CustomCircularProgresIndecator()
                        : CustomElevatedButton(
                            name: "login".tr(),
                            width: SizeConfig.width * 0.9,
                            hPadding: SizeConfig.width * 0.03,
                            onPressed: () {
                              context.read<SignInCubit>().signIn();
                            },
                            backgroundColor: AppColors.kPrimaryColor,
                          );
                  },
                ),
                const OrSignWith(),
                const SocialSignIn(),
                SizedBox(height: SizeConfig.height * 0.02),
                HaveAccountOrNot(
                  title: "dont_have_account".tr(),
                  value: "signup".tr(),
                  onPressed: () => context.pushScreen(RouteNames.selectRoleScreen),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
