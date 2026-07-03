import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fixmate/core/utilies/assets/images/app_images.dart';

class SplashScreenBody extends StatelessWidget {
  const SplashScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Image.asset( 
        AppImages.logoImage,
        fit: BoxFit.contain,
      )
          .animate()
          .slide(
            duration: 1000.ms,
            begin: const Offset(1, 0),
            curve: Curves.easeOutCubic,
          )
          .fadeIn(duration: 1000.ms)
          .scale(duration: 1000.ms)
          .then(delay: 300.ms),
    );
  }
}
