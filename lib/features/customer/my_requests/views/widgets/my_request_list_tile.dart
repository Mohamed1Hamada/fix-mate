import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/features/technician/customer_requests/models/technician_requests_model.dart';
import 'package:flutter/material.dart';

class CustomerRequestListTile extends StatelessWidget {
  const CustomerRequestListTile({
    super.key,
    required this.index,
    required this.requestModel,
  });
  final int index;
  final TechnicianRequestModel requestModel;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 300 + index * 50),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: SizeConfig.height * 0.02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.width * 0.03),
          child: Row(
            children: [
              // Technician Image
              Hero(
                tag: 'request_${requestModel.id}',
                child: Container(
                  width: SizeConfig.width * 0.18,
                  height: SizeConfig.width * 0.18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    image: DecorationImage(
                      image: NetworkImage(requestModel.technician!.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: SizeConfig.width * 0.03),
              // Request Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            requestModel.technician!.fullName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.title18BlackBold,
                          ),
                        ),
                        _buildStatusChip(requestModel.status),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      requestModel.technician!.specialty!.name,
                      style: AppTextStyles.title14Grey,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined,
                            size: 14, color: AppColors.kPrimaryColor),
                        SizedBox(width: 4),
                        Text(
                          requestModel.requestDate != null
                              ? DateFormat('yyyy-MM-dd – hh:mm a',
                                      context.locale.languageCode)
                                  .format(requestModel.requestDate!)
                              : 'not_available'.tr(),
                          style: AppTextStyles.title12Grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(RequestStatus status) {
    Color color;
    switch (status) {
      case RequestStatus.pending:
        color = Colors.orange;
        break;
      case RequestStatus.accepted:
        color = Colors.blue;
        break;
      case RequestStatus.completed:
        color = Colors.green;
        break;
      case RequestStatus.cancelled:
        color = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.name.tr(),
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
