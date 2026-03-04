import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeDeleteBackground extends StatelessWidget {
  const HomeDeleteBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.w),
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.delete, color: Colors.white, size: 32.sp),
          4.verticalSpace,
          Text(
            'Delete',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
    
  }
}