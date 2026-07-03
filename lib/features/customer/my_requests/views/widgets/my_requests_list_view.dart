import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/customer/my_requests/views/widgets/my_request_list_tile.dart';
import 'package:fixmate/features/customer/nearest_technicians/views/widgets/empty_lottie.dart';
import 'package:fixmate/features/technician/customer_requests/models/technician_requests_model.dart';
import 'package:flutter/cupertino.dart';

class MyRequestsListView extends StatelessWidget {
  const MyRequestsListView({
    super.key,
    required this.customerRequests,
  });
  final List<TechnicianRequestModel> customerRequests;
  @override
  Widget build(BuildContext context) {
    return customerRequests.isEmpty
        ? EmptyLottie()
        : ListView.separated(
            itemCount: customerRequests.length,
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.02,
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: SizeConfig.height * 0.02,
            ),
            itemBuilder: (context, index) => CustomerRequestListTile(
              key: ValueKey(customerRequests[index].id),
              requestModel: customerRequests[index],
              index: index,
            ),
          );
  }
}
