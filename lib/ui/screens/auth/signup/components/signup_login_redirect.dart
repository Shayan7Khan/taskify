import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/constants/strings/app_strings.dart';
import 'package:taskify/ui/screens/auth/signup/signup_view_model.dart';

class SignupLoginRedirect extends StatelessWidget {
  final SignUpViewModel model;
  const SignupLoginRedirect({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: model.loginRedirectOpacity,
      duration: const Duration(milliseconds: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.alreadyHaveAccount,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
          ),
          GestureDetector(
            onTap: () => model.goToLogin(context),
            child: Text(
              AppStrings.login,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF4C766E),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
