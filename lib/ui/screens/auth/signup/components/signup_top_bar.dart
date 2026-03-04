import 'package:flutter/material.dart';
import 'package:taskify/ui/custom_widgets/custom_top_bar_bubble.dart';
import 'package:taskify/ui/screens/auth/signup/signup_view_model.dart';

class SignupTopBar extends StatelessWidget {
  final SignUpViewModel model;
  const SignupTopBar({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: model.bubbleScale,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      child: const TopBarBubble(),
    );
  }
}
