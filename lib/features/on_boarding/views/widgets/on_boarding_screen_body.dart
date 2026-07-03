import 'package:fixmate/core/app_route/route_names.dart';
import 'package:fixmate/core/utilies/extensions/app_extensions.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/on_boarding/view_models/cubit/on_boarding_cubit.dart';
import 'package:fixmate/features/on_boarding/views/widgets/custom_on_boarding_app_bar.dart';
import 'package:fixmate/features/on_boarding/views/widgets/next_page_button.dart';
import 'package:fixmate/features/on_boarding/views/widgets/on_boarding_steps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingScreenBody extends StatelessWidget {
  const OnBoardingScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: BlocListener<OnBoardingCubit, int>(
        listener: (context, state) {
          if (state == 3) {
            context.pushReplacementScreen(RouteNames.signInScreen);
          }
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.02,
              vertical: SizeConfig.height * 0.01,
            ),
            child: Column(
              children: [
                CustomOnBoardingAppBar(),
                OnBoardingSteps(),
                SizedBox(height: SizeConfig.height * 0.03),
                NextPageButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

