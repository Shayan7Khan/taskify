import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/ui/screens/add_task/add_task_view_model.dart';

class AddTaskPrioritySelection extends StatelessWidget {
  final AddTaskViewModel model;
  const AddTaskPrioritySelection({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: model.priorities.map((priority) {
        final isSelected = model.selectedPriority == priority;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: GestureDetector(
              onTap: () => model.setPriority(priority),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: isSelected ? priority.color : Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isSelected ? priority.color : Colors.grey[300]!,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    priority.displayName.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.grey[700],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
