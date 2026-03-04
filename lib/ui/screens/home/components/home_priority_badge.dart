import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/constants/enums/priority.dart';

class HomePriorityBadge extends StatelessWidget {
  final Priority priority;
  
  const HomePriorityBadge({super.key, required this.priority,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: priority.color,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        priority.displayName.toUpperCase(),
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    
  }
}
