import 'package:fixmate/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingCubit extends Cubit<int> {
  OnBoardingCubit() : super(0);

  final PageController pageController = PageController(initialPage: 0);
  int steps = AppConstants.onboardingSteps.length;
  
  void nextPage() {
    if (state < steps - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInCirc,
      );
      final newIndex = state + 1;
      emit(newIndex);
    } else {
      emit(steps);
    }
  }

  void previousPage() {
    if (state > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      final newIndex = state - 1;
      emit(newIndex);
    }
  }

  void changePage(int index) {
    pageController.jumpToPage(index);
    emit(index);
  }
}
