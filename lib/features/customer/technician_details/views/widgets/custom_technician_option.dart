import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';

class CustomTechnicianOption extends StatelessWidget {
  const CustomTechnicianOption({
    super.key,
    required this.icon,
    this.onPressed,
    this.backgroundColor,
  });
  final IconData icon;
  final Function()? onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.height * 0.005),
      decoration: BoxDecoration(
        color:
            backgroundColor ?? AppColors.kPrimaryColor.withValues(alpha: 0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: IconButton(
        color: Colors.white,
        iconSize: SizeConfig.width * 0.07,
        padding: EdgeInsets.zero,
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );
  }
}
