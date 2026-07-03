import 'package:fixmate/core/utilies/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.icon,
    this.child,
    this.onPressed,
    this.iconColor,
    this.iconSize,
    this.weight,
    this.backgroundColor,
    this.hPadding,
    this.vPadding,
  });

  final Widget? icon;
  final Widget? child;
  final Function()? onPressed;
  final Color? iconColor;
  final double? iconSize;
  final double? weight;
  final Color? backgroundColor;
  final double? hPadding;
  final double? vPadding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.grey.shade500,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: hPadding ?? context.screenWidth * 0.03,
            vertical: vPadding ?? context.screenWidth * 0.03,
          ),
          child: Center(
            // هنا الهندلة:
            // الأولوية دائماً للـ child، إذا لم يوجد ننتقل للـ icon، وإذا لم يوجد نضع أيقونة خطأ.
            child:
                child ?? icon ?? const Icon(Icons.error, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
