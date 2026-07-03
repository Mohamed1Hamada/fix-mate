import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/cache/cache_helper.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/features/customer/my_chats/views/widgets/customer_header.dart';
import 'package:flutter/material.dart';

class TechnicianHeader extends StatelessWidget {
  const TechnicianHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var customerModel = getIt<CacheHelper>().getUserModel();
    return CustomHeader(
      child: Row(
        children: [
          Text(
            "👋",
            style: AppTextStyles.title36PrimaryColorBold,
          ),
          SizedBox(width: SizeConfig.width * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${'hi'.tr()}, ${customerModel?.fullName ?? ''}',
                style: AppTextStyles.title24WhiteW500,
              ),
              Text(
                'find_technician'.tr(),
                style: AppTextStyles.title16White70,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
