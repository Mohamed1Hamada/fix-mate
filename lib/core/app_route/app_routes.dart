import 'package:fixmate/features/auth/select_role/views/screens/select_role_screen.dart';
import 'package:fixmate/features/chat/views/screens/chat_screen.dart';
import 'package:fixmate/features/customer/home/views/screens/customer_home_screen.dart';
import 'package:fixmate/features/customer/nearest_technicians/views/screens/nearest_technicians_screens.dart';
import 'package:fixmate/features/customer/technician_details/views/screens/technician_details_screen.dart';
import 'package:fixmate/features/on_boarding/views/screens/on_boarding_screen.dart';
import 'package:fixmate/features/splash/views/screens/splash_screen.dart';
import 'package:fixmate/features/technician/complete_profile/view_models/cubit/complete_technician_profile_cubit.dart';
import 'package:fixmate/features/technician/complete_profile/views/screens/complete_profile_screen.dart';
import 'package:fixmate/features/technician/home/views/screens/customer_home_screen.dart';
import 'package:fixmate/features/technician/request_details/views/screens/request_details_screen.dart';
import 'package:fixmate/features/customer/ai_chat/views/screens/maintenance_aI_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixmate/core/app_route/route_names.dart';
import 'package:fixmate/features/auth/sign_in/view_models/cubit/sign_in_cubit.dart';
import 'package:fixmate/features/auth/sign_in/views/screens/sign_in_screen.dart';
import 'package:fixmate/features/auth/sign_up/view_models/cubit/sign_up_cubit.dart';
import 'package:fixmate/features/auth/sign_up/views/screens/sign_up_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes =
      <String, WidgetBuilder>{
    RouteNames.splashScreen: (context) => const SplashScreen(),
    RouteNames.onBoardingScreen: (context) => const OnBoardingScreen(),
    RouteNames.signInScreen: (context) => BlocProvider(
          create: (context) => SignInCubit(),
          child: const SignInScreen(),
        ),
    RouteNames.signUpScreen: (context) => BlocProvider(
          create: (context) => SignUpCubit(),
          child: const SignUpScreen(),
        ),
    RouteNames.selectRoleScreen: (context) => const SelectRoleScreen(),
    RouteNames.customerHomeScreen: (context) => const CustomerHomeScreen(),
    RouteNames.nearestTechniciansScreen: (context) =>
        const NearestTechniciansScreen(),
    RouteNames.technicianDetailsScreen: (context) =>
        const TechnicianDetailsScreen(),
    RouteNames.compleTechnicianProfileScreen: (context) => BlocProvider(
          create: (context) => CompleteTechnicianProfileCubit(),
          child: const CompleteTechnicianProfileScreen(),
        ),
    RouteNames.technicianHomeScreen: (context) => const TechnicianHomeScreen(),
    RouteNames.chatScreen: (context) => const ChatScreen(),
    RouteNames.requestDetailsScreen: (context) => const CustomerRequestDetailScreen(),
    RouteNames.maintenanceAIChatScreen: (context) => const MaintenanceAIChatScreen(),
  };
}
