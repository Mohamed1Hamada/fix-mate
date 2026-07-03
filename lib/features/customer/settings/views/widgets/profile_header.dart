import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/features/auth/sign_in/models/user_model.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.customerModel});
  final UserModel customerModel;
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: SizeConfig.height * 0.07,
          backgroundImage: NetworkImage(
            customerModel.image,
          ),
        ),
        SizedBox(height: SizeConfig.height * 0.01),
        Text(customerModel.userName, style: AppTextStyles.title16WhiteW600),
      ],
    );
  }
}
