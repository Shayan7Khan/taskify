import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taskify/core/constants/enums/view_state.dart';
import 'package:taskify/ui/screens/add_task/add_task_view_model.dart';
import 'package:taskify/ui/custom_widgets/custom_text_form_field.dart';
import 'package:taskify/ui/custom_widgets/custom_elevated_button.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddTaskViewModel(),
      child: Consumer<AddTaskViewModel>(
        builder: (context, model, child) => Container(
          // Take 70% of screen height
          height: MediaQuery.of(context).size.height * 0.7,
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            top: 20.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: model.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                      icon: Icon(
                        Icons.access_time,
                        color: const Color(0xFF55847A),
                      ),
                      onPressed: () => model.pickTime(context),
                    ),
                    onTap: () => model.pickTime(context),
                  ),

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
                  Row(
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
                                color: isSelected
                                    ? _getPriorityColor(priority)
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: isSelected
                                      ? _getPriorityColor(priority)
                                      : Colors.grey[300]!,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  priority.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey[700],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  30.verticalSpace,

                  // Add task button
                  Center(
                    child: CustomElevatedButton(
                      title: model.state == ViewState.busy
                          ? 'Adding Task...'
                          : 'Add Task',
                      onPressed: model.state == ViewState.busy
                          ? null
                          : () => model.addTask(context),
                    ),
                  ),

                  10.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
