import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/model/task_model.dart';

class HomeCheckBox extends StatelessWidget {
  final TaskModel task;
  const HomeCheckBox({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.w,
      height: 24.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: task.isCompleted ? Colors.green : Colors.grey.shade300,
      ),
      child: Icon(Icons.check, size: 16.sp, color: Colors.white),
    );
  }
}
