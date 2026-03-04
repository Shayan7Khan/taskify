import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/constants/strings/app_strings.dart';
import 'package:taskify/ui/custom_widgets/custom_text_form_field.dart';
import 'package:taskify/ui/screens/auth/signup/signup_view_model.dart';

class SignupTextFields extends StatelessWidget {
  final SignUpViewModel model;
  const SignupTextFields({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Center(
          child: AnimatedSlide(
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
                    AppStrings.createAccount,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32.sp,
                      color: const Color(0xFF4C766E),
                    ),
                  ),
                  8.verticalSpace,
                  Text(
                    AppStrings.signUpSubtitle,
                    style: TextStyle(fontSize: 15.sp, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
        ),
        40.verticalSpace,
        // Add this after the header, before name field
        AnimatedSlide(
          offset: model.imagePickerOffset,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          child: AnimatedOpacity(
            opacity: model.imagePickerOpacity,
            duration: const Duration(milliseconds: 400),
            child: Center(
              child: GestureDetector(
                onTap: () => model.pickProfileImage(context),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60.r,
                      backgroundColor: Color(0xFF4C766E).withValues(alpha: 0.1),
                      backgroundImage: model.profileImage != null
                          ? FileImage(model.profileImage!)
                          : null,
                      child: model.profileImage == null
                          ? Icon(
                              Icons.person,
                              size: 50.sp,
                              color: Color(0xFF4C766E),
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: Color(0xFF4C766E),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          size: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        40.verticalSpace,
        // Name field
        AnimatedSlide(
          offset: model.nameFieldOffset,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          child: AnimatedOpacity(
            opacity: model.nameFieldOpacity,
            duration: const Duration(milliseconds: 400),
            child: CustomTextFormField(
              controller: model.nameController,
              label: AppStrings.fullName,
              hint: AppStrings.enterFullName,
              validator: model.validateName,
            ),
          ),
        ),

        20.verticalSpace,

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
              hint: AppStrings.createPassword,
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

        20.verticalSpace,

        // Confirm Password field
        AnimatedSlide(
          offset: model.confirmPasswordFieldOffset,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          child: AnimatedOpacity(
            opacity: model.confirmPasswordFieldOpacity,
            duration: const Duration(milliseconds: 400),
            child: CustomTextFormField(
              controller: model.confirmPasswordController,
              label: AppStrings.confirmPassword,
              hint: AppStrings.reEnterPassword,
              obscureText: model.obscureConfirmPassword,
              validator: model.validateConfirmPassword,
              suffixIcon: IconButton(
                icon: Icon(
                  model.obscureConfirmPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.grey[600],
                ),
                onPressed: model.toggleConfirmPasswordVisibility,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
