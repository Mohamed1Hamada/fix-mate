import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/helper/launch_link.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class ViewLocationOnMapButton extends StatelessWidget {
  const ViewLocationOnMapButton({
    super.key,
    required this.lat,
    required this.lng,
  });
  final double lat;
  final double lng;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        urlLauncher(url: 'https://maps.google.com/?q=$lat,$lng');
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.height * 0.025,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.kPrimaryColor,
              AppColors.kPrimaryColor.withValues(alpha: 0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.kPrimaryColor.withValues(alpha: 0.4),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: Colors.white,
              size: SizeConfig.width * 0.06,
            ),
            SizedBox(width: SizeConfig.width * 0.02),
            Text(
              'view_location'.tr(),
              style: AppTextStyles.title18WhiteW500,
            ),
            SizedBox(width: SizeConfig.width * 0.02),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: SizeConfig.width * 0.04,
            ),
          ],
        ),
      ),
    );
  }
}
