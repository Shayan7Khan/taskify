import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/constants/strings/app_strings.dart';
import 'package:taskify/ui/screens/auth/signup/signup_view_model.dart';

class SignupTermsCondition extends StatelessWidget {
  final SignUpViewModel model;
  const SignupTermsCondition({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
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
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
                  children: [
                    TextSpan(text: AppStrings.termsAgreement),
                    TextSpan(
                      text: AppStrings.termsAndConditions,
                      style: const TextStyle(
                        color: Color(0xFF4C766E),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(text: AppStrings.and),
                    TextSpan(
                      text: AppStrings.privacyPolicy,
                      style: const TextStyle(
                        color: Color(0xFF4C766E),
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
    );
  }
}
