import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taskify/core/constants/enums.dart';
import 'package:taskify/ui/custom_widgets/custom_elevated_button.dart';
import 'package:taskify/ui/screens/auth/auth_custom_widgets/custom_text_form_field.dart';
import 'package:taskify/ui/custom_widgets/custom_top_bar_bubble.dart';
import 'package:taskify/ui/screens/auth/signup/signup_view_model.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(context),
      child: Consumer<SignUpViewModel>(
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
                          40.verticalSpace,
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
                                      'Create Account',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32.sp,
                                        color: const Color(0xFF4C766E),
                                      ),
                                    ),
                                    8.verticalSpace,
                                    Text(
                                      'Sign up to start organizing your tasks',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
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
                                label: 'Full Name',
                                hint: 'Enter your full name',
                                errorText: model.nameError,
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
                                hint: 'Create a password',
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
                                label: 'Confirm Password',
                                hint: 'Re-enter your password',
                                obscureText: model.obscureConfirmPassword,
                                errorText: model.confirmPasswordError,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    model.obscureConfirmPassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Colors.grey[600],
                                  ),
                                  onPressed:
                                      model.toggleConfirmPasswordVisibility,
                                ),
                              ),
                            ),
                          ),
                      
                          20.verticalSpace,
                      
                          // Terms and conditions checkbox
                          AnimatedOpacity(
                            opacity: model.termsOpacity,
                            duration: const Duration(milliseconds: 400),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: model.acceptedTerms,
                                  onChanged: (value) => model.toggleTerms(),
                                  activeColor: const Color(0xFF4C766E),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: model.toggleTerms,
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.grey[600],
                                        ),
                                        children: [
                                          const TextSpan(text: 'I agree to the '),
                                          TextSpan(
                                            text: 'Terms & Conditions',
                                            style: TextStyle(
                                              color: const Color(0xFF4C766E),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const TextSpan(text: ' and '),
                                          TextSpan(
                                            text: 'Privacy Policy',
                                            style: TextStyle(
                                              color: const Color(0xFF4C766E),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      
                          if (model.termsError != null)
                            Padding(
                              padding: EdgeInsets.only(left: 16.w),
                              child: Text(
                                model.termsError!,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                      
                          30.verticalSpace,
                      
                          // Sign up button
                          Center(
                            child: AnimatedScale(
                              scale: model.buttonScale,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOutBack,
                              child: CustomElevatedButton(
                                title: model.state == ViewState.busy
                                    ? 'Creating Account...'
                                    : 'Sign Up',
                                onPressed: model.state == ViewState.busy
                                    ? null
                                    : () => model.signUp(),
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
                      
                          // Social signup buttons
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
                                      onPressed: model.signUpWithGoogle,
                                    ),
                                  ),
                                  16.horizontalSpace,
                                  Expanded(
                                    child: _buildSocialButton(
                                      icon: Icons.apple,
                                      label: 'Apple',
                                      onPressed: model.signUpWithApple,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      
                          40.verticalSpace,
                      
                          // Login redirect
                          AnimatedOpacity(
                            opacity: model.loginRedirectOpacity,
                            duration: const Duration(milliseconds: 400),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account? ',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => model.goToLogin(context),
                                  child: Text(
                                    'Login',
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
