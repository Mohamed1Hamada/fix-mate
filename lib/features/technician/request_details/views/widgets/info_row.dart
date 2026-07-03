import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.height * 0.02),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.02,
              vertical: SizeConfig.height * 0.01,
            ),
            decoration: BoxDecoration(
              color: AppColors.kPrimaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppColors.kPrimaryColor,
              size: SizeConfig.height * 0.035,
            ),
          ),
          SizedBox(width: SizeConfig.width * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.title14Grey600),
                SizedBox(height: SizeConfig.height * 0.003),
                Text(
                  value,
                  style: AppTextStyles.title16Black87W600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
