import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/constants/app_constants.dart';
import 'package:fixmate/features/on_boarding/view_models/cubit/on_boarding_cubit.dart';
import 'package:fixmate/features/on_boarding/views/widgets/custom_on_boarding_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingSteps extends StatelessWidget {
  const OnBoardingSteps({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, int>(
      builder: (context, state) {
        var cubit = context.read<OnBoardingCubit>();
        return Expanded(
          child: PageView.builder(
            itemCount: cubit.steps,
            onPageChanged: cubit.changePage,
            controller: cubit.pageController,
            itemBuilder: (context, index) {
              var step = AppConstants.onboardingSteps[index];
              return CustomOnBoardingStep(
                title: step.title.tr(),
                description: step.description.tr(),
                image: step.image,
              );
            },
          ),
        );
      },
    );
  }
}
