import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taskify/ui/screens/auth/signup/components/signup_form_field.dart';
import 'package:taskify/ui/screens/auth/signup/components/signup_top_bar.dart';
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
              SignupTopBar(model: model),
              SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: SignupFormField(model: model)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
