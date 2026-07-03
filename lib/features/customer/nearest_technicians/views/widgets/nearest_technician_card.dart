import 'package:fixmate/core/app_route/route_names.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/extensions/app_extensions.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/features/auth/sign_in/models/technician_model.dart';
import 'package:flutter/material.dart';

class NearestTechnicianCard extends StatelessWidget {
  const NearestTechnicianCard({
    super.key,
    required this.tech,
  });

  final TechnicianModel tech;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.height * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.kPrimaryColor.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          contentPadding: EdgeInsets.all(SizeConfig.height * 0.02),
          leading: CircleAvatar(
            radius: SizeConfig.height * 0.035,
            backgroundImage: NetworkImage(tech.image),
          ),
          title: Text(
            tech.fullName,
            style: AppTextStyles.title18PrimaryColorW500,
          ),
          subtitle: Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
                size: SizeConfig.width * 0.05,
              ),
              SizedBox(width: SizeConfig.width * 0.01),
              Text(
                tech.rating.toStringAsFixed(1),
                style: AppTextStyles.title14BlackColorW400,
              ),
              SizedBox(width: SizeConfig.width * 0.02),
              Icon(
                Icons.location_on_outlined,
                color: AppColors.kPrimaryColor,
                size: SizeConfig.width * 0.05,
              ),
              SizedBox(width: SizeConfig.width * 0.01),
              Text(
                tech.distance != null
                    ? '${tech.distance!.toStringAsFixed(4)} km'
                    : 'N/A',
                style: AppTextStyles.title14BlackColorW400,
              ),
            ],
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.kPrimaryColor,
            size: SizeConfig.width * 0.05,
          ),
          onTap: () {
            context.pushScreen(
              RouteNames.technicianDetailsScreen,
              arguments: tech.toJson(),
            );
          },
        ),
      ),
    );
  }
}
