import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/constants/strings/app_strings.dart';
import 'package:taskify/ui/screens/auth/login/components/login_social_button.dart';
import 'package:taskify/ui/screens/auth/login/login_view_model.dart';

class LoginSocialAuth extends StatelessWidget {
  final LoginViewModel model;
  const LoginSocialAuth({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Social login buttons
        AnimatedSlide(
          offset: model.socialButtonsOffset,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          child: AnimatedOpacity(
            opacity: model.socialButtonsOpacity,
            duration: const Duration(milliseconds: 400),
            child: Row(
              children: [
                Expanded(
                  child: LoginSocialButton(
                    icon: Icons.g_mobiledata_rounded,
                    label: AppStrings.google,
                    onPressed: model.loginWithGoogle,
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: LoginSocialButton(
                    icon: Icons.apple,
                    label: AppStrings.apple,
                    onPressed: model.loginWithApple,
                  ),
                ),
              ],
            ),
          ),
        ),
        40.verticalSpace,
        // Sign up redirect
        AnimatedOpacity(
          opacity: model.signupRedirectOpacity,
          duration: const Duration(milliseconds: 400),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.dontHaveAccount,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
              ),
              GestureDetector(
                onTap: () => model.goToSignUp(context),
                child: Text(
                  AppStrings.signUp,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF4C766E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
