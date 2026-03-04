import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/constants/strings/app_strings.dart';
import 'package:taskify/ui/custom_widgets/custom_text_form_field.dart';
import 'package:taskify/ui/screens/auth/login/login_view_model.dart';

class LoginTextFields extends StatelessWidget {
  final LoginViewModel model;
  const LoginTextFields({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        60.verticalSpace,
        // Header
        AnimatedSlide(
          offset: model.headerOffset,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          child: AnimatedOpacity(
            opacity: model.headerOpacity,
            duration: const Duration(milliseconds: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.welcomeBack,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.sp,
                    color: const Color(0xFF4C766E),
                  ),
                ),
                8.verticalSpace,
                Text(
                  AppStrings.loginSubtitle,
                  style: TextStyle(fontSize: 15.sp, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
        50.verticalSpace,
        // Email field
        AnimatedSlide(
          offset: model.emailFieldOffset,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          child: AnimatedOpacity(
            opacity: model.emailFieldOpacity,
            duration: const Duration(milliseconds: 400),
            child: CustomTextFormField(
              controller: model.emailController,
              label: AppStrings.email,
              hint: AppStrings.enterEmail,
              keyboardType: TextInputType.emailAddress,
              validator: model.validateEmail,
            ),
          ),
        ),
        20.verticalSpace,
        // Password field
        AnimatedSlide(
          offset: model.passwordFieldOffset,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          child: AnimatedOpacity(
            opacity: model.passwordFieldOpacity,
            duration: const Duration(milliseconds: 400),
            child: CustomTextFormField(
              controller: model.passwordController,
              label: AppStrings.password,
              hint: AppStrings.enterPassword,
              obscureText: model.obscurePassword,
              validator: model.validatePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  model.obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey[600],
                ),
                onPressed: model.togglePasswordVisibility,
              ),
            ),
          ),
        ),
        12.verticalSpace,
        // Forgot password
        AnimatedOpacity(
          opacity: model.forgotPasswordOpacity,
          duration: const Duration(milliseconds: 400),
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: model.goToForgotPassword,
              child: Text(
                AppStrings.forgotPassword,
                style: TextStyle(
                  color: const Color(0xFF4C766E),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
