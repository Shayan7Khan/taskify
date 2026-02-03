import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taskify/core/constants/enums.dart';
import 'package:taskify/ui/custom_widgets/custom_elevated_button.dart';
import 'package:taskify/ui/screens/auth/auth_custom_widgets/custom_text_form_field.dart';
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
                                  'Welcome Back',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32.sp,
                                    color: const Color(0xFF4C766E),
                                  ),
                                ),
                                8.verticalSpace,
                                Text(
                                  'Login to continue your productivity journey',
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
                              label: 'Email',
                              hint: 'Enter your email',
                              keyboardType: TextInputType.emailAddress,
                              errorText: model.emailError,
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
                              label: 'Password',
                              hint: 'Enter your password',
                              obscureText: model.obscurePassword,
                              errorText: model.passwordError,
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
                                'Forgot Password?',
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
                                  ? 'Logging in...'
                                  : 'Login',
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
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Text(
                                  'OR',
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
                                    label: 'Google',
                                    onPressed: model.loginWithGoogle,
                                  ),
                                ),
                                16.horizontalSpace,
                                Expanded(
                                  child: _buildSocialButton(
                                    icon: Icons.apple,
                                    label: 'Apple',
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
                                "Don't have an account? ",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                              GestureDetector(
                                onTap: () => model.goToSignUp(context),
                                child: Text(
                                  'Sign Up',
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
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildTextField({
  //   required TextEditingController controller,
  //   required String label,
  //   required String hint,
  //   bool obscureText = false,
  //   TextInputType? keyboardType,
  //   String? errorText,
  //   Widget? suffixIcon,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         label,
  //         style: TextStyle(
  //           fontSize: 14.sp,
  //           fontWeight: FontWeight.w600,
  //           color: Colors.grey[800],
  //         ),
  //       ),
  //       8.verticalSpace,
  //       TextField(
  //         controller: controller,
  //         obscureText: obscureText,
  //         keyboardType: keyboardType,
  //         decoration: InputDecoration(
  //           hintText: hint,
  //           hintStyle: TextStyle(color: Colors.grey[400]),
  //           suffixIcon: suffixIcon,
  //           errorText: errorText,
  //           filled: true,
  //           fillColor: Colors.grey[100],
  //           border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(12.r),
  //             borderSide: BorderSide.none,
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(12.r),
  //             borderSide: BorderSide.none,
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(12.r),
  //             borderSide: const BorderSide(color: Color(0xFF4C766E), width: 2),
  //           ),
  //           errorBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(12.r),
  //             borderSide: const BorderSide(color: Colors.red, width: 1),
  //           ),
  //           contentPadding: EdgeInsets.symmetric(
  //             horizontal: 16.w,
  //             vertical: 16.h,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

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
