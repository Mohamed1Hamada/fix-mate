import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/customer/my_chats/views/widgets/customer_header.dart';
import 'package:fixmate/features/customer/my_requests/views/widgets/custom_tab_bar.dart';
import 'package:fixmate/features/customer/nearest_technicians/views/widgets/custom_failure_message.dart';
import 'package:fixmate/features/customer/nearest_technicians/views/widgets/custom_loading_indicator.dart';
import 'package:fixmate/features/customer/nearest_technicians/views/widgets/empty_lottie.dart';
import 'package:fixmate/features/technician/customer_requests/models/technician_requests_model.dart';
import 'package:fixmate/features/technician/customer_requests/view_models/cubit/customer_requests_cubit.dart';
import 'package:fixmate/features/technician/customer_requests/views/widgets/customer_request_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerRequestsScreen extends StatelessWidget {
  const CustomerRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomerRequestsScreenBody(),
    );
  }
}

class CustomerRequestsScreenBody extends StatelessWidget {
  const CustomerRequestsScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeader(
          icon: CupertinoIcons.list_bullet_indent,
          title: "requests".tr(),
        ),
        SizedBox(height: SizeConfig.height * 0.02),
        Expanded(
          child: DefaultTabController(
            length: RequestStatus.values.length,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.03,
                
              ),
              child: Column(
                children: [
                  CustomTabBar(
                    tabs: RequestStatus.values.map((e) => e.name.tr()).toList(),
                  ),
                  SizedBox(height: SizeConfig.height * 0.03),
                  CustomCustomerRequestsTabBarView()
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CustomCustomerRequestsTabBarView extends StatelessWidget {
  const CustomCustomerRequestsTabBarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CustomerRequestsCubit, CustomerRequestsState>(
        builder: (context, state) {
          if (state is CustomerRequestsLoading) {
            return CustomLoadingIndicator();
          }
          if (state is CustomerRequestsError) {
            return CustomFailureMesage(errorMessage: state.message);
          }
          return TabBarView(
            children: RequestStatus.values
                .map(
                  (e) => RequestsListView(
                    customerRequests: context
                            .read<CustomerRequestsCubit>()
                            .requestsByStatus[e] ??
                        [],
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}

class RequestsListView extends StatelessWidget {
  const RequestsListView({
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
