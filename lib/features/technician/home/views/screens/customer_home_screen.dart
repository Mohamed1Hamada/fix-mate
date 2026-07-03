import 'package:fixmate/core/constants/app_constants.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/technician/home/view_models/cubit/technician_bottom_nav_bar_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class TechnicianHomeScreen extends StatelessWidget {
  const TechnicianHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TechnicianBottomNavBarCubit(),
        child: BlocBuilder<TechnicianBottomNavBarCubit, int>(
          builder: (context, currentIndex) {
            final cubit = context.read<TechnicianBottomNavBarCubit>();
            return Scaffold(
              body: AppConstants.techniciansScreens[currentIndex],
              bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: Colors.transparent,
                color: AppColors.kPrimaryColor,
                height: SizeConfig.height * 0.08,
                animationDuration: const Duration(milliseconds: 400),
                index: currentIndex,
                items: const [
                  Icon(Icons.handyman, color: Colors.white),
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
