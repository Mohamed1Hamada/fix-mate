import 'package:fixmate/core/constants/app_constants.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/customer/home/view_models/cubit/customer_bottom_nav_bar_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fixmate/core/app_route/route_names.dart';
import 'package:fixmate/core/utilies/extensions/app_extensions.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CustomerBottomNavBarCubit(),
        child: BlocBuilder<CustomerBottomNavBarCubit, int>(
          builder: (context, currentIndex) {
            final cubit = context.read<CustomerBottomNavBarCubit>();
            return Scaffold(
              body: AppConstants.customersScreens[currentIndex],
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  context.pushScreen(RouteNames.maintenanceAIChatScreen);
                },
                backgroundColor: AppColors.kPrimaryColor,
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.psychology_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: Colors.transparent,
                color: AppColors.kPrimaryColor,
                height: SizeConfig.height * 0.08,
                animationDuration: const Duration(milliseconds: 400),
                index: currentIndex,
                items: const [
                  Icon(Icons.handyman, color: Colors.white),
                  Icon(Icons.receipt_long, color: Colors.white),
                  Icon(CupertinoIcons.chat_bubble_2_fill, color: Colors.white),
                  Icon(Icons.settings, color: Colors.white),
                ],
                onTap: cubit.changeTab,
              ),
            );
          },
        ));
  }
}
