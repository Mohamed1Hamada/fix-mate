import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        color: AppColors.kPrimaryColor,
        size: SizeConfig.height * 0.1,
      ),
    );
  }
}

