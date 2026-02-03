import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/core/base_class/base_view_model.dart';

class OnboardingViewModel extends BaseViewModel {
  double bubbleScale = 0;
  Offset headerOffset = const Offset(-1, 0);
  Offset imageOffset = const Offset(1, 0);
  Offset footerOffset = const Offset(-1, 0);
  double buttonScale = 0;

  OnboardingViewModel() {
    animateSequence();
  }

  void animateSequence() async {
    // Bubble pop
    bubbleScale = 1;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 200));

    // Header slide
    headerOffset = const Offset(0, 0);
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 200));

    // Image slide
    imageOffset = const Offset(0, 0);
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 200));

    // Footer slide
    footerOffset = const Offset(0, 0);
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 200));

    // Button pop
    buttonScale = 1;
    notifyListeners();
  }

  void goToSignUpButton(BuildContext context) {
    context.goNamed('signup');
  }
}
