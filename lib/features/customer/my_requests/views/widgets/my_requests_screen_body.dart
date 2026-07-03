import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/customer/my_chats/views/widgets/customer_header.dart';
import 'package:fixmate/features/customer/my_requests/view_models/cubit/my_requests_cubit.dart';
import 'package:fixmate/features/customer/my_requests/views/widgets/custom_tab_bar.dart';
import 'package:fixmate/features/customer/my_requests/views/widgets/my_requests_list_view.dart';
import 'package:fixmate/features/customer/nearest_technicians/views/widgets/custom_failure_message.dart';
import 'package:fixmate/features/customer/nearest_technicians/views/widgets/custom_loading_indicator.dart';
import 'package:fixmate/features/technician/customer_requests/models/technician_requests_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyRequestsScreenBody extends StatelessWidget {
  const MyRequestsScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: RequestStatus.values.length,
        child: Column(
          children: [
            CustomHeader(icon: Icons.receipt_long, title: "requests".tr()),
            SizedBox(
              height: SizeConfig.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.03,
              ),
              child: CustomTabBar(
                  tabs: [
                    "pending".tr(),
                    "accepted".tr(),
                    "completed".tr(),
                    "cancelled".tr()
                  ]),
            ),
            SizedBox(height: SizeConfig.height * 0.03),
            const CustomRequestsTabBarView()
          ],
        ),
      ),
    );
  }
}

class CustomRequestsTabBarView extends StatelessWidget {
  const CustomRequestsTabBarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
  var cubit = context.read<MyRequestsCubit>();
    return Expanded(
      child: BlocBuilder<MyRequestsCubit, MyRequestsState>(
        builder: (context, state) {
          if (state is GetMyRequestsLoading) {
            return CustomLoadingIndicator();
          }
          if (state is GetMyRequestsError) {
            return CustomFailureMesage(errorMessage: state.message);
          }
          var requests = cubit.requestsByStatus;
          return TabBarView(
            children: RequestStatus.values
                .map(
                  (e) => MyRequestsListView(
                    customerRequests: requests[e]!,
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
