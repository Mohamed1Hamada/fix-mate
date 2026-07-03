import 'package:fixmate/core/components/custom_circular_progress_indecator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixmate/core/components/custom_icon_button.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/auth/sign_in/view_models/cubit/sign_in_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialSignIn extends StatelessWidget {
  const SocialSignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomIconButton(
          iconSize: SizeConfig.width * 0.07,
          backgroundColor: AppColors.kPrimaryColor,
          iconColor: AppColors.kBackgroundColor,
          icon: const Icon(Icons.facebook),
          onPressed: () {},
        ),
        BlocBuilder<SignInCubit, SignInState>(
          buildWhen: (previous, current) =>
              current is SignInWithGoogleLoading ||
              previous is SignInWithGoogleLoading,
          builder: (context, state) {
            return state is SignInWithGoogleLoading
                ? const CustomCircularProgresIndecator()
                : CustomIconButton(
                    iconSize: SizeConfig.width * 0.07,
                    backgroundColor: AppColors.kPrimaryColor,
                    iconColor: AppColors.kBackgroundColor,
                    icon: FaIcon(
                      FontAwesomeIcons.google,
                    ),
                    onPressed: () {
                      context.read<SignInCubit>().signInWithGoogle();
                    },
                  );
          },
        ),
        CustomIconButton(
          iconSize: SizeConfig.width * 0.07,
          backgroundColor: AppColors.kPrimaryColor,
          iconColor: AppColors.kBackgroundColor,
          icon: const Icon(
            Icons.apple,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
