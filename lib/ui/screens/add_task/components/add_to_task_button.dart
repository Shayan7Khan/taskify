import 'package:flutter/material.dart';
import 'package:taskify/core/constants/enums/view_state.dart';
import 'package:taskify/ui/custom_widgets/custom_elevated_button.dart';
import 'package:taskify/ui/screens/add_task/add_task_view_model.dart';

class AddToTaskButton extends StatelessWidget {
  final AddTaskViewModel model;
  const AddToTaskButton({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomElevatedButton(
        title: model.state == ViewState.busy ? 'Adding Task...' : 'Add Task',
        onPressed: model.state == ViewState.busy
            ? null
            : () => model.addTask(context),
      ),
    );
  }
}
