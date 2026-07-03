import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.height * 0.05,
      child: VerticalDivider(
        color: AppColors.kPrimaryColor.withValues(alpha: 0.5),
        thickness: 1,
      ),
    );
  }
}
