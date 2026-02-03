import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/core/base_class/base_view_model.dart';

class SplashViewModel extends BaseViewModel {
  final BuildContext context;

  // Animation states
  double _iconScale = 0.0;
  double _iconRotation = -0.5;
  double _textOpacity = 0.0;
  double _taglineOpacity = 0.0;
  double _loaderOpacity = 0.0;
  double _backgroundOpacity = 0.0;
  Offset _textOffset = const Offset(0, 0.5);
  Offset _taglineOffset = const Offset(0, 0.5);
  

  // Getters
  double get iconScale => _iconScale;
  double get iconRotation => _iconRotation;
  double get textOpacity => _textOpacity;
  double get taglineOpacity => _taglineOpacity;
  double get loaderOpacity => _loaderOpacity;
  double get backgroundOpacity => _backgroundOpacity;
  Offset get textOffset => _textOffset;
  Offset get taglineOffset => _taglineOffset;

  SplashViewModel(this.context) {
    _startAnimations();
  }

  void _startAnimations() async {
    // Animate background circles
    await Future.delayed(const Duration(milliseconds: 100));
    _backgroundOpacity = 1.0;
    notifyListeners();

    // Animate icon scale and rotation
    await Future.delayed(const Duration(milliseconds: 300));
    _iconScale = 1.0;
    _iconRotation = 0.0;
    notifyListeners();

    // Animate app name
    await Future.delayed(const Duration(milliseconds: 400));
    _textOpacity = 1.0;
    _textOffset = const Offset(0, 0);
    notifyListeners();

    // Animate tagline
    await Future.delayed(const Duration(milliseconds: 200));
    _taglineOpacity = 1.0;
    _taglineOffset = const Offset(0, 0);
    notifyListeners();

    // Show loader
    await Future.delayed(const Duration(milliseconds: 400));
    _loaderOpacity = 1.0;
    notifyListeners();

    // Navigate to onboarding after total duration
    await Future.delayed(const Duration(milliseconds: 1500));
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() {
    context.goNamed('onboarding');

    debugPrint(
      'Navigate to Onboarding Screen - Update route name in SplashViewModel',
    );
  }
}
