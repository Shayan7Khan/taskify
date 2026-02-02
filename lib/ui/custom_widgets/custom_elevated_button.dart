import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const CustomElevatedButton({super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
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
      child: Text(title),
    );
  }
}
