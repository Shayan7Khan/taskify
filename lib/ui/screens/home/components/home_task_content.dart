import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/model/task_model.dart';
import 'package:taskify/ui/screens/home/components/home_priority_badge.dart';

class HomeTaskContent extends StatelessWidget {
  final TaskModel task;
  const HomeTaskContent({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
              10.horizontalSpace,
            HomePriorityBadge(priority: task.priority),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            task.description,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
              decoration: task.isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            task.time,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
