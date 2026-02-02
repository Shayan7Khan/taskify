import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taskify/ui/custom_widgets/custom_elevated_button.dart';
import 'package:taskify/ui/custom_widgets/custom_top_bar_bubble.dart';
import 'package:taskify/ui/screens/onboarding/onboarding_view_model.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingViewModel(),
      child: Consumer<OnboardingViewModel>(
        builder: (context, model, child) => Scaffold(
          body: Stack(
            children: [
              AnimatedScale(
                scale: model.bubbleScale,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                child: TopBarBubble(),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      50.verticalSpace,
                      AnimatedSlide(
                        offset: model.headerOffset,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        child: headerText(),
                      ),
                      Spacer(flex: 1),
                      AnimatedSlide(
                        offset: model.imageOffset,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        child: image(),
                      ),

                      20.verticalSpace,
                      AnimatedSlide(
                        offset: model.footerOffset,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        child: footerText(),
                      ),
                      80.verticalSpace,
                      AnimatedScale(
                        scale: model.buttonScale,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutBack,
                        child: CustomElevatedButton(
                          title: 'Get Started',
                          onPressed: ()  {
                          
                            model.goToSignUpButton(context);
                          },
                        ),
                      ),
                      Spacer(flex: 1),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //* header text
  Widget headerText() {
    return Text(
      'Taskify',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40.sp,
        color: Color(0xFF4C766E),
      ),
    );
  }

  //* image
  Widget image() {
    return Center(
      child: Image.asset('assets/images/onboarding.png', height: 250.h),
    );
  }

  //* footer text
  Widget footerText() {
    return Text(
      'Your day, your plan. Stay focused, finish stronger.',
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
    );
  }
}
