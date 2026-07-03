import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/features/technician/request_details/views/widgets/info_row.dart';
import 'package:flutter/material.dart';

class CustomerRequestDate extends StatelessWidget {
  const CustomerRequestDate({
    super.key,
    required this.requestDate,
    this.completedDate,
  });

  final DateTime? completedDate;
  final DateTime requestDate;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoRow(
          icon: Icons.schedule,
          label: 'request_date'.tr(),
          value: _formatDate(context, requestDate),
        ),
        if (completedDate != null)
          InfoRow(
            icon: Icons.check_circle,
            label: 'completed_date'.tr(),
            value: _formatDate(context, completedDate!),
          ),
      ],
    );
  }

  String _formatDate(BuildContext context, DateTime date) {
    return DateFormat('yyyy-MM-dd – hh:mm a', context.locale.languageCode).format(date);
  }
}
