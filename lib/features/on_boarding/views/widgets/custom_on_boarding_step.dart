import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomOnBoardingStep extends StatelessWidget {
  const CustomOnBoardingStep({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });
  final String image;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.05,
        vertical: SizeConfig.height * 0.02,
      ),
      child: Column(
        children: [
          Text(
            title,
            style: AppTextStyles.title36PrimaryColorW500,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SizeConfig.height * 0.02),
          Text(
            description,
            style: AppTextStyles.title18GreyW500,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SizeConfig.height * 0.01),
          Expanded(child: Lottie.asset(image,fit: BoxFit.contain)),
        ],
      ),
    );
  }
}
