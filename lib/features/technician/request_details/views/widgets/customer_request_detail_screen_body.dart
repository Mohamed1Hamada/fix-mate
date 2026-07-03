import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/features/customer/my_chats/views/widgets/customer_header.dart';
import 'package:fixmate/features/technician/customer_requests/models/technician_requests_model.dart';
import 'package:fixmate/features/technician/request_details/views/widgets/customer_details.dart';
import 'package:fixmate/features/technician/request_details/views/widgets/customer_request_date.dart';
import 'package:fixmate/features/technician/request_details/views/widgets/customer_request_description.dart';
import 'package:fixmate/features/technician/request_details/views/widgets/customer_request_image.dart';
import 'package:fixmate/features/technician/request_details/views/widgets/customer_request_status.dart';
import 'package:fixmate/features/technician/request_details/views/widgets/view_location_on_map_button.dart';
import 'package:flutter/cupertino.dart';

class CustomerRequestDetailScreenBody extends StatelessWidget {
  const CustomerRequestDetailScreenBody({
    super.key,
    required this.request,
  });

  final TechnicianRequestModel request;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeader(
          title: request.title,
          icon: CupertinoIcons.list_bullet_indent,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.03,
              vertical: SizeConfig.height * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomerRequestImage(requestImage: request.imageUrl!),
                SizedBox(height: SizeConfig.height * 0.02),
                Text(request.title,
                    style: AppTextStyles.title24PrimaryColorBold),
                SizedBox(height: SizeConfig.height * 0.02),
                CustomerRequestDescription(
                    requestDescription: request.description!),
                SizedBox(height: SizeConfig.height * 0.02),
                CustomerRequestStatus(requestStatus: request.status),
                SizedBox(height: SizeConfig.height * 0.02),
                CustomerRequestDate(
                  requestDate: request.requestDate ?? request.createdAt,
                  completedDate: request.completedAt,
                ),
                SizedBox(height: SizeConfig.height * 0.02),
                CustomerDetails(userModel: request.customer!),
                SizedBox(height: SizeConfig.height * 0.02),
                ViewLocationOnMapButton(
                  lat: request.customerLatitude!,
                  lng: request.customerLongitude!,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
