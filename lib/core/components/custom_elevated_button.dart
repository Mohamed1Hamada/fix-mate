import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/extensions/app_extensions.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.name,
    this.onPressed,
    this.textStyle,
    this.hPadding,
    this.wPadding,
    this.height,
    this.width,
    this.backgroundColor,
    this.forgroundColor,
  });

  final String name;
  final Function()? onPressed;
  final TextStyle? textStyle;
  final double? hPadding, wPadding;
  final double? height, width;
  final Color? backgroundColor;
  final Color? forgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.kPrimaryColor,
        side: BorderSide(color: AppColors.kPrimaryColor),
        foregroundColor: forgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: wPadding ?? context.screenWidth * 0.05,
          vertical: hPadding ?? context.screenHeight * 0.01,
        ),
        minimumSize: (width != null || height != null)
            ? Size(width ?? 0, height ?? 0)
            : null, 
      ),
      onPressed: onPressed,
      child: Text(
        name,
        style: textStyle ?? AppTextStyles.title20WhiteW500,
      ),
    );
  }
}
