import 'package:fixmate/core/utilies/assets/lotties/app_lotties.dart';
import 'package:fixmate/features/customer/my_chats/view_models/cubit/my_chats_cubit.dart';
import 'package:fixmate/features/customer/my_chats/views/widgets/customer_chats_screen_body.dart';
import 'package:fixmate/features/customer/my_requests/view_models/cubit/my_requests_cubit.dart';
import 'package:fixmate/features/customer/my_requests/views/widgets/my_requests_screen_body.dart';
import 'package:fixmate/features/customer/settings/views/widgets/customer_settings_screen_body.dart';
import 'package:fixmate/features/customer/technician_specialties/view_models/cubit/technicians_cubit.dart';
import 'package:fixmate/features/customer/technician_specialties/views/widgets/technician_specialties_body.dart';
import 'package:fixmate/features/on_boarding/models/on_boarding_step_model.dart';
import 'package:fixmate/features/technician/customer_chats/view_models/cubit/my_chats_cubit.dart';
import 'package:fixmate/features/technician/customer_chats/views/widgets/customer_chats_screen_body.dart';
import 'package:fixmate/features/technician/customer_requests/models/technician_requests_model.dart';
import 'package:fixmate/features/technician/customer_requests/view_models/cubit/customer_requests_cubit.dart';
import 'package:fixmate/features/technician/customer_requests/views/screens/customer_requests_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppConstants {
  static final List<OnBoardingStepModel> onboardingSteps = [
    OnBoardingStepModel(
        title: "onboarding_title_1",
        description: "onboarding_desc_1",
        image: AppLotties.welcomeLottie),
    OnBoardingStepModel(
      title: "onboarding_title_2",
      description: "onboarding_desc_2",
      image: AppLotties.repairLottie,
    ),
    OnBoardingStepModel(
      title: "onboarding_title_3",
      description: "onboarding_desc_3",
      image: AppLotties.workGrowthLottie,
    ),
  ];
  //
  //
  static List<Widget> get customersScreens => [
        BlocProvider(
          create: (context) => TechniciansCubit(),
          child: const TechnicianSpecialtiesBody(),
        ),
        BlocProvider(
          create: (context) => MyRequestsCubit(),
          child: const MyRequestsScreenBody(),
        ),
        BlocProvider(
          create: (context) => MyChatsCubit(),
          child: const MyChatsScreenBody(),
        ),
        const CustomerSettingsScreenBody(),
      ];
  //
  static List<Widget> get techniciansScreens => [
        BlocProvider(
          create: (context) => CustomerRequestsCubit(),
          child: const CustomerRequestsScreenBody(),
        ),
        BlocProvider(
          create: (context) => CustomerChatsCubit(),
          child: const CustomerChatsScreenBody(),
        ),
        const CustomerSettingsScreenBody(),
      ];
  //
  static final Map<RequestStatus, Color> statusColors = {
    RequestStatus.pending: Colors.orange,
    RequestStatus.accepted: Colors.blue,
    RequestStatus.completed: Colors.green,
    RequestStatus.cancelled: Colors.red,
  };

  static final Map<RequestStatus, IconData> statusIcons = {
    RequestStatus.pending: Icons.hourglass_empty,
    RequestStatus.accepted: Icons.build,
    RequestStatus.completed: Icons.check,
    RequestStatus.cancelled: Icons.cancel,
  };
  //
  static const String maintenanceAIWelcomeMessage =
      'Hello! I\'m your home maintenance assistant. You can ask me about common issues, simple safe fixes, or describe an image of a problem for diagnosis. I can also suggest the right technician category for you. What do you need today?';
}
