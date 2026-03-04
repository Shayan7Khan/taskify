import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/ui/screens/auth/login/components/login_button.dart';
import 'package:taskify/ui/screens/auth/login/components/login_divider.dart';
import 'package:taskify/ui/screens/auth/login/components/login_social_auth.dart';
import 'package:taskify/ui/screens/auth/login/components/login_text_fields.dart';
import 'package:taskify/ui/screens/auth/login/login_view_model.dart';

class LoginFormField extends StatelessWidget {
  final LoginViewModel model;

  const LoginFormField({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: model.formKey,
      child: Column(
        children: [
          LoginTextFields(model: model),
          30.verticalSpace,
          LoginButton(model: model),
          30.verticalSpace,
          LoginDivider(model: model),
          30.verticalSpace,
          LoginSocialAuth(model: model),
          40.verticalSpace,
        ],
      ),
    );
  }
}
