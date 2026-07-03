import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';

class CustomerRequestImage extends StatelessWidget {
  const CustomerRequestImage({
    super.key,
    required this.requestImage,
  });

  final String requestImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(requestImage),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
    );
  }
}
