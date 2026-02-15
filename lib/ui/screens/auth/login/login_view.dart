import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taskify/core/constants/enums/view_state.dart';
import 'package:taskify/core/constants/strings/app_strings.dart';
import 'package:taskify/ui/custom_widgets/custom_elevated_button.dart';
import 'package:taskify/ui/custom_widgets/custom_text_form_field.dart';
import 'package:taskify/ui/custom_widgets/custom_top_bar_bubble.dart';
import 'package:taskify/ui/screens/auth/login/login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(context),
      child: Consumer<LoginViewModel>(
        builder: (context, model, child) => Scaffold(
          body: Stack(
            children: [
              // Top bubble decoration
              AnimatedScale(
                scale: model.bubbleScale,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                child: const TopBarBubble(),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Form(
                      key: model.formKey,
                      child: Column(
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
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.grey[600],
                                    ),
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

                          30.verticalSpace,

                          // Login button
                          Center(
                            child: AnimatedScale(
                              scale: model.buttonScale,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOutBack,
                              child: CustomElevatedButton(
                                title: model.state == ViewState.busy
                                    ? AppStrings.loggingIn
                                    : AppStrings.login,
                                onPressed: model.state == ViewState.busy
                                    ? null
                                    : () => model.login(),
                              ),
                            ),
                          ),

                          30.verticalSpace,

                          // Divider with "OR"
                          AnimatedOpacity(
                            opacity: model.dividerOpacity,
                            duration: const Duration(milliseconds: 400),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey[400],
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                  ),
                                  child: Text(
                                    AppStrings.orDivider,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey[400],
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          30.verticalSpace,

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
                                    child: _buildSocialButton(
                                      icon: Icons.g_mobiledata_rounded,
                                      label: AppStrings.google,
                                      onPressed: model.loginWithGoogle,
                                    ),
                                  ),
                                  16.horizontalSpace,
                                  Expanded(
                                    child: _buildSocialButton(
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
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[600],
                                  ),
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

                          40.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        side: BorderSide(color: Colors.grey[300]!, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24.sp, color: Colors.grey[800]),
          8.horizontalSpace,
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
