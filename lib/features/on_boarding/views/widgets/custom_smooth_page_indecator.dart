import 'package:fixmate/core/constants/app_constants.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSmoothPageIndecator extends StatelessWidget {
  const CustomSmoothPageIndecator({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: AppConstants.onboardingSteps.length,
      effect: ExpandingDotsEffect(
        dotWidth: SizeConfig.height * 0.008,
        dotHeight: SizeConfig.height * 0.008,
        spacing: SizeConfig.width * 0.015,
        dotColor: Colors.grey,
        activeDotColor: AppColors.kPrimaryColor,
      ),
    );
  }
}
