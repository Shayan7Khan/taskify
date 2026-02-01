import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/ui/widget/top_bar_bubble.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TopBarBubble(),
          SafeArea(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  40.verticalSpace,
                  headerText(),
                  Spacer(flex: 1),
                  image(),
                  20.verticalSpace,
                  footerText(),
                  80.verticalSpace,
                  button(),
                  Spacer(flex: 1),
                ],
              ),
            ),
          ),
        ],
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
    return Center(child: Image.asset('assets/images/onboarding.png'));
  }

  //* footer text
  Widget footerText() {
    return Text(
      'Your day, your plan. Stay focused, finish stronger.',
      textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
    );
  }

  //*button
  Widget button() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF55847A),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 15.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 5,
        textStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
      ),
      child: Text('Get Started'),
    );
  }
}
