import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/constants/strings/app_strings.dart';
import 'package:taskify/ui/screens/auth/login/login_view_model.dart';

class LoginDivider extends StatelessWidget {
  final LoginViewModel model;
  const LoginDivider({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: model.dividerOpacity,
      duration: const Duration(milliseconds: 400),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey[400], thickness: 1)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              AppStrings.orDivider,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey[400], thickness: 1)),
        ],
      ),
    );
  }
}
