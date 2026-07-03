import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.trailingIcon,
    this.onTrailingTap,
  });
  final IconData icon;
  final String label;
  final String value;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: SizeConfig.height * 0.03,
        backgroundColor: AppColors.kPrimaryColor.withValues(alpha: 0.1),
        child: Icon(icon,
            color: AppColors.kPrimaryColor, size: SizeConfig.width * 0.07),
      ),
      title: Text(
        label,
        style: AppTextStyles.title14Grey600,
      ),
      subtitle: Text(
        value,
        style: AppTextStyles.title16Black87W600,
      ),
      trailing: trailingIcon != null
          ? IconButton(
              icon:
                  Icon(trailingIcon, size: 20, color: AppColors.kPrimaryColor),
              onPressed: onTrailingTap,
            )
          : null,
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    );
  }
}
