import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/ui/custom_widgets/custom_text_form_field.dart';
import 'package:taskify/ui/screens/add_task/add_task_view_model.dart';

class AddTaskTextFields extends StatelessWidget {
  final AddTaskViewModel model;
  const AddTaskTextFields({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Handle bar
        Center(
          child: Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ),
        20.verticalSpace,
        // Header
        Text(
          'Add New Task',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF55847A),
          ),
        ),
        30.verticalSpace,
        // Title field
        CustomTextFormField(
          controller: model.titleController,
          label: 'Task Title',
          hint: 'Enter task title',
          validator: model.validateTitle,
        ),
        20.verticalSpace,
        // Description field
        CustomTextFormField(
          controller: model.descriptionController,
          label: 'Description',
          hint: 'Enter task description',
          maxLines: 3,
          validator: model.validateDescription,
        ),
        20.verticalSpace,
        // Time field
        CustomTextFormField(
          controller: model.timeController,
          label: 'Time',
          hint: 'Select time',
          readOnly: true,
          validator: model.validateTime,
          suffixIcon: IconButton(
            icon: Icon(Icons.access_time, color: const Color(0xFF55847A)),
            onPressed: () => model.pickTime(context),
          ),
          onTap: () => model.pickTime(context),
        ),
      ],
    );
  }
}
