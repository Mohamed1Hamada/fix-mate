import 'package:flutter/material.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    this.onPressed,
    required this.title,
    this.style,
    this.alignment,
    this.backgroundColor,
    this.hPadding,
    this.vPadding,
  });

  final Function()? onPressed;
  final String title;
  final TextStyle? style;
  final AlignmentGeometry? alignment;
  final Color? backgroundColor;
  final double? hPadding;
  final double? vPadding;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.topCenter,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: backgroundColor ?? Colors.transparent,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: hPadding ?? SizeConfig.width * 0.02,
            vertical: vPadding ?? SizeConfig.height * 0.008,
          ),
          child: Text(
            title,
            style: style ?? AppTextStyles.title16PrimaryColorW500,
          ),
        ),
      ),
    );
  }
}
