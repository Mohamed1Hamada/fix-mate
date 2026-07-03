import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/customer/technician_specialties/models/technician_specialtie_model.dart';
import 'package:flutter/material.dart';

class TechnicianSpecialtyCard extends StatelessWidget {
  final TechnicianSpecialtyModel tech;
  final bool isSelected;
  final VoidCallback onTap;

  const TechnicianSpecialtyCard({
    super.key,
    required this.tech,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? 0.93 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isSelected
                  ? [
                      AppColors.kPrimaryColor.withValues(alpha: 0.12),
                      Colors.white,
                    ]
                  : [
                      Colors.white,
                      Colors.white,
                    ],
            ),
            borderRadius: BorderRadius.circular(SizeConfig.width * 0.04),
            border: Border.all(
              color: isSelected
                  ? AppColors.kPrimaryColor
                  : AppColors.kPrimaryColor.withValues(alpha: 0.25),
              width: isSelected ? 2 : 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.kPrimaryColor.withValues(alpha: 0.08),
                blurRadius: SizeConfig.width * 0.03,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(SizeConfig.width * 0.03),
                  child: Hero(
                    tag: tech.image,
                    child: Image.network(
                      tech.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(SizeConfig.width * 0.04),
                    ),
                  ),
                  child: Text(
                    tech.name.tr(),
                    style: TextStyle(
                      fontSize: SizeConfig.width * 0.045,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w600,
                      color: AppColors.kPrimaryColor,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
