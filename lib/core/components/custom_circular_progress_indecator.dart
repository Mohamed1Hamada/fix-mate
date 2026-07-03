import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';

class CustomCircularProgresIndecator extends StatelessWidget {
  const CustomCircularProgresIndecator({
    super.key,
    this.height,
  });
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? SizeConfig.height * 0.1,
      child: Center(
        child: CircularProgressIndicator(
          color: AppColors.kPrimaryColor,
        ),
      ),
    );
  }
}
