import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/on_boarding/view_models/cubit/on_boarding_cubit.dart';
import 'package:fixmate/features/on_boarding/views/widgets/custom_smooth_page_indecator.dart';
import 'package:fixmate/core/app_route/route_names.dart';
import 'package:fixmate/core/components/custom_text_button.dart';
import 'package:fixmate/core/utilies/extensions/app_extensions.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomOnBoardingAppBar extends StatelessWidget {
  const CustomOnBoardingAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: SizeConfig.width * 0.15,
        ),
        CustomSmoothPageIndecator(
          pageController: context.read<OnBoardingCubit>().pageController,
        ),
        CustomTextButton(
          backgroundColor: AppColors.kPrimaryColor,
          hPadding: SizeConfig.width * 0.035,
          title: "skip".tr(),
          onPressed: () {
            context.pushReplacementScreen(RouteNames.signInScreen);
          },
          alignment: Alignment.center,
          style: AppTextStyles.title18WhiteW500,
        ),
      ],
    );
  }
}
