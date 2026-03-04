import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/ui/screens/add_task/add_task_view_model.dart';
import 'package:taskify/ui/screens/add_task/components/add_task_priority_selection.dart';
import 'package:taskify/ui/screens/add_task/components/add_task_text_fields.dart';
import 'package:taskify/ui/screens/add_task/components/add_to_task_button.dart';

class AddTaskFields extends StatelessWidget {
  final AddTaskViewModel model;
  const AddTaskFields({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: model.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //textfields
          AddTaskTextFields(model: model),
          20.verticalSpace,
          // Priority label
          Text(
            'Priority',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          10.verticalSpace,
          // Priority selection
          AddTaskPrioritySelection(model: model),
          30.verticalSpace,
          // Add task button
          AddToTaskButton(model: model),
          10.verticalSpace,
        ],
      ),
    );
  }
}
