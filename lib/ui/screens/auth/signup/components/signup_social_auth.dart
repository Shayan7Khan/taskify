import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/constants/strings/app_strings.dart';
import 'package:taskify/ui/screens/auth/signup/components/signup_social_button.dart';
import 'package:taskify/ui/screens/auth/signup/signup_view_model.dart';

class SignupSocialAuth extends StatelessWidget {
  final SignUpViewModel model;
  const SignupSocialAuth({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: model.socialButtonsOffset,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: model.socialButtonsOpacity,
        duration: const Duration(milliseconds: 400),
        child: Row(
          children: [
            Expanded(
              child: SignupSocialButton(
                icon: Icons.g_mobiledata_outlined,
                label: AppStrings.google,
                onPressed: model.signUpWithGoogle,
              ),
            ),
            16.horizontalSpace,
            Expanded(
              child: SignupSocialButton(
                icon: Icons.apple,
                label: AppStrings.apple,
                onPressed: model.signUpWithApple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
