import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/ui/screens/auth/signup/components/signup_button.dart';
import 'package:taskify/ui/screens/auth/signup/components/signup_divider.dart';
import 'package:taskify/ui/screens/auth/signup/components/signup_login_redirect.dart';
import 'package:taskify/ui/screens/auth/signup/components/signup_social_auth.dart';
import 'package:taskify/ui/screens/auth/signup/components/signup_terms_condition.dart';
import 'package:taskify/ui/screens/auth/signup/components/signup_text_fields.dart';
import 'package:taskify/ui/screens/auth/signup/signup_view_model.dart';

class SignupFormField extends StatelessWidget {
  final SignUpViewModel model;
  const SignupFormField({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: model.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          40.verticalSpace,
          //Text fields
          SignupTextFields(model: model),
          20.verticalSpace,
          //Terms and condition
          SignupTermsCondition(model: model),
          30.verticalSpace,
          if (model.termsError != null)
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Text(
                model.termsError!,
                style: TextStyle(color: Colors.red, fontSize: 12.sp),
              ),
            ),
          // Sign up button
          SignupButton(model: model),
          30.verticalSpace,
          // Divider with "OR"
          SignupDivider(model: model),
          30.verticalSpace,
          // Social signup buttons
          SignupSocialAuth(model: model),
          40.verticalSpace,
          // Login redirect
          SignupLoginRedirect(model: model),
          40.verticalSpace,
        ],
      ),
    );
  }
}
