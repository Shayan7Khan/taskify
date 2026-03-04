import 'package:flutter/material.dart';
import 'package:taskify/ui/screens/home/components/home_task_card.dart';
import 'package:taskify/ui/screens/home/home_view_model.dart';

class HomeTaskListView extends StatelessWidget {
  final HomeViewModel model;
  const HomeTaskListView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: model.tasks.length,
      itemBuilder: (context, index) {
        final task = model.tasks[index];
        return HomeTaskCard(model: model, task: task);
      },
    );
  
  }
}
