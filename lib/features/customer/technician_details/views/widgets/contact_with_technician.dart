import 'package:fixmate/core/app_route/route_names.dart';
import 'package:fixmate/core/cache/cache_helper.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/core/helper/launch_link.dart';
import 'package:fixmate/core/utilies/extensions/app_extensions.dart';
import 'package:fixmate/features/chat/models/chat_model.dart';
import 'package:fixmate/features/customer/technician_details/views/widgets/custom_technician_option.dart';
import 'package:fixmate/features/customer/technician_details/views/widgets/custom_vertical_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactWithTechnician extends StatelessWidget {
  const ContactWithTechnician({
    super.key,
    required this.technicianId,
    required this.technicianPhoneNumber,
  });
  final String technicianId;
  final String technicianPhoneNumber;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomTechnicianOption(
          icon: Icons.call,
          onPressed: () {
            urlLauncher(url: "tel:$technicianPhoneNumber");
          },
        ),
        CustomVerticalDivider(),
        CustomTechnicianOption(
          icon: CupertinoIcons.chat_bubble,
          onPressed: () {
            context.pushScreen(
              RouteNames.chatScreen,
              arguments: ChatModel(
                id: technicianId +
                    getIt<CacheHelper>().getUserModel()!.id.toString(),
                customerId: getIt<CacheHelper>().getUserModel()!.id.toString(),
                technicianId: technicianId,
              ).toJson(),
            );
          },
        ),
      ],
    );
  }
}
