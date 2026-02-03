import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taskify/ui/screens/splash/splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashViewModel(context),
      child: Consumer<SplashViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: const Color(0xFF4C766E),
          body: Stack(
            children: [
              // Animated background circles
              Positioned(
                top: -100.h,
                right: -100.w,
                child: AnimatedOpacity(
                  opacity: model.backgroundOpacity,
                  duration: const Duration(milliseconds: 800),
                  child: Container(
                    width: 300.w,
                    height: 300.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -150.h,
                left: -150.w,
                child: AnimatedOpacity(
                  opacity: model.backgroundOpacity,
                  duration: const Duration(milliseconds: 800),
                  child: Container(
                    width: 350.w,
                    height: 350.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                ),
              ),

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated checkmark icon
                    AnimatedScale(
                      scale: model.iconScale,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.elasticOut,
                      child: AnimatedRotation(
                        turns: model.iconRotation,
                        duration: const Duration(milliseconds: 600),
                        child: Container(
                          width: 120.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.check_circle_rounded,
                            size: 70.sp,
                            color: const Color(0xFF4C766E),
                          ),
                        ),
                      ),
                    ),
                    40.verticalSpace,
                    // Animated app name
                    AnimatedSlide(
                      offset: model.textOffset,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOut,
                      child: AnimatedOpacity(
                        opacity: model.textOpacity,
                        duration: const Duration(milliseconds: 800),
                        child: Text(
                          'Taskify',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 48.sp,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    // Animated tagline
                    AnimatedSlide(
                      offset: model.taglineOffset,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOut,
                      child: AnimatedOpacity(
                        opacity: model.taglineOpacity,
                        duration: const Duration(milliseconds: 800),
                        child: Text(
                          'Organize. Focus. Achieve.',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white.withValues(alpha: 0.9),
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Loading indicator at bottom
              Positioned(
                bottom: 80.h,
                left: 0,
                right: 0,
                child: AnimatedOpacity(
                  opacity: model.loaderOpacity,
                  duration: const Duration(milliseconds: 400),
                  child: Center(
                    child: SizedBox(
                      width: 40.w,
                      height: 40.h,
                      child: CircularProgressIndicator(
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                        strokeWidth: 3,
                      ),
                    ),
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
