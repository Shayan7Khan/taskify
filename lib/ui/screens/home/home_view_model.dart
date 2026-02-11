import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/core/base_class/base_view_model.dart';
import 'package:taskify/core/constants/enums.dart';
import 'package:taskify/core/dummy_tasks.dart';
import 'package:taskify/core/model/task_model.dart';
import 'package:taskify/core/services/auth_service.dart';
import 'package:taskify/core/strings/app_strings.dart';
import 'package:taskify/locator.dart';

class HomeViewModel extends BaseViewModel {
  final AuthService _authService = locator.get<AuthService>();
  List<TaskModel> tasks = [];

  HomeViewModel() {
    getTasks();
  }

  List<TaskModel> getTasks() {
    setState(ViewState.busy);
    final response = DummyTasks.dummyTasks;
    tasks = response.map((json) => TaskModel.fromJson(json)).toList();
    setState(ViewState.idle);
    return tasks;
  }

  toggleIsCompleted(task) {
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.logoutTitle),
        content: Text(AppStrings.logoutMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppStrings.logoutCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppStrings.logoutTitle, style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirm == true) {
      await _authService.logOut();
      if (context.mounted) {
        context.goNamed('login');
      }
    }
  }
}
