import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taskify/ui/custom_widgets/custom_top_bar_bubble.dart';
import 'package:taskify/ui/screens/auth/login/components/login_form_field.dart';
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
                    child: LoginFormField(model: model),
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
