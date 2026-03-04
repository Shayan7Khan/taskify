import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeEmptyState extends StatelessWidget {
  const HomeEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 100.h),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.task_alt, size: 100.sp, color: Colors.grey[300]),
              20.verticalSpace,
              Text(
                'No tasks yet!',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              10.verticalSpace,
              Text(
                'Pull down to refresh or tap + to add a task',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}