import 'package:flutter/material.dart';
import 'package:taskify/core/constants/enums/view_state.dart';
import 'package:taskify/core/constants/strings/app_strings.dart';
import 'package:taskify/ui/custom_widgets/custom_elevated_button.dart';
import 'package:taskify/ui/screens/auth/login/login_view_model.dart';

class LoginButton extends StatelessWidget {
  final LoginViewModel model;
  const LoginButton({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedScale(
        scale: model.buttonScale,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        child: CustomElevatedButton(
          title: model.state == ViewState.busy
              ? AppStrings.loggingIn
              : AppStrings.login,
          onPressed: model.state == ViewState.busy ? null : () => model.login(),
        ),
      ),
    );
  }
}
