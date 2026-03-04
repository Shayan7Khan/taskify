import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSectionTitle extends StatelessWidget {
  const HomeSectionTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Todo Tasks',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.sp,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
  }
