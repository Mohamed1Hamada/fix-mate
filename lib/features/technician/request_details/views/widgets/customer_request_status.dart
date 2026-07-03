import 'package:fixmate/core/constants/app_constants.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/features/technician/customer_requests/models/technician_requests_model.dart';
import 'package:flutter/material.dart';

class CustomerRequestStatus extends StatelessWidget {
  const CustomerRequestStatus({
    super.key,
    required this.requestStatus,
  });

  final RequestStatus requestStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.045,
        vertical: SizeConfig.height * 0.013,
      ),
      decoration: BoxDecoration(
        color: AppConstants.statusColors[requestStatus],
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppConstants.statusColors[requestStatus]!
                .withValues(alpha: 0.4),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            AppConstants.statusIcons[requestStatus],
            color: Colors.white,
            size: SizeConfig.width * 0.06,
          ),
          SizedBox(width: SizeConfig.width * 0.02),
          Text(
            requestStatus.name,
            style: AppTextStyles.title16WhiteW600,
          ),
        ],
      ),
    );
  }
}
