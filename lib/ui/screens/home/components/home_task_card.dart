import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/core/model/task_model.dart';
import 'package:taskify/ui/screens/home/components/home_check_box.dart';
import 'package:taskify/ui/screens/home/components/home_delete_background.dart';
import 'package:taskify/ui/screens/home/components/home_task_content.dart';
import 'package:taskify/ui/screens/home/home_view_model.dart';

class HomeTaskCard extends StatelessWidget {
  final HomeViewModel model;
  final TaskModel task;
  const HomeTaskCard({super.key, required this.model, required this.task});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.endToStart,
      background: HomeDeleteBackground(),
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Task'),
            content: Text('Delete "${task.title}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        model.deleteTask(context, task);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => model.toggleIsCompleted(task),
                child: HomeCheckBox(task: task),
              ),
              15.horizontalSpace,
              HomeTaskContent(task: task),
            ],
          ),
        ),
      ),
    );
  }
}
