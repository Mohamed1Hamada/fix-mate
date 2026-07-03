import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/features/customer/technician_details/views/widgets/frosted_glass_container.dart';
import 'package:flutter/material.dart';

class TechnicianInfoRow extends StatelessWidget {
  const TechnicianInfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FrostedGlassContainer(
      child: Row(
        children: [
          Icon(icon, size: SizeConfig.width * 0.07, color: Colors.white),
          SizedBox(width: SizeConfig.width * 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.title16White70.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
              Text(
                value,
                style: AppTextStyles.title18WhiteW500.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
