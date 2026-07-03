import 'package:fixmate/core/helper/launch_link.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/features/auth/sign_in/models/user_model.dart';
import 'package:flutter/material.dart';

class CustomerDetails extends StatelessWidget {
  const CustomerDetails({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.03,
        vertical: SizeConfig.height * 0.015,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: SizeConfig.width * 0.08,
            backgroundImage: NetworkImage(userModel.image),
          ),
          SizedBox(width: SizeConfig.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userModel.fullName, style: AppTextStyles.title18BlackBold),
                SizedBox(height: SizeConfig.height * 0.005),
                Text(userModel.email, style: AppTextStyles.title14Grey600),
                SizedBox(height: SizeConfig.height * 0.005),
                Text(userModel.phoneNumber,
                    style: AppTextStyles.title14Grey600),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              urlLauncher(url: 'tel:${userModel.phoneNumber}');
            },
            icon: const Icon(Icons.phone, color: Colors.green),
          ),
        ],
      ),
    );
  }
}
