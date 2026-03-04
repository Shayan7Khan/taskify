import 'package:flutter/material.dart';
import 'package:taskify/ui/screens/home/components/home_empty_state.dart';
import 'package:taskify/ui/screens/home/components/home_task_list_view.dart';
import 'package:taskify/ui/screens/home/home_view_model.dart';

class HomeTaskList extends StatelessWidget {
  final HomeViewModel model;
  const HomeTaskList({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: model.onRefresh,
        color: const Color(0xFF55847A),
        backgroundColor: Colors.white,
        child: model.tasks.isEmpty
            ? HomeEmptyState()
            : HomeTaskListView(model: model),
      ),
    );
  }
}
