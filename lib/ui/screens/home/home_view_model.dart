import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/core/base_class/base_view_model.dart';
import 'package:taskify/core/constants/enums/view_state.dart';
import 'package:taskify/core/constants/strings/app_strings.dart';
import 'package:taskify/core/logge_customizations/custom_logger.dart';
import 'package:taskify/core/model/task_model.dart';
import 'package:taskify/core/model/user_model.dart';
import 'package:taskify/core/services/auth_service.dart';
import 'package:taskify/core/services/database_service.dart';
import 'package:taskify/locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeViewModel extends BaseViewModel {
  final CustomLogger log = CustomLogger(className: 'Home View Model');
  final AuthService _authService = locator.get<AuthService>();
  final DatabaseService _taskService = locator<DatabaseService>();
  final _supabase = Supabase.instance.client;

  List<TaskModel> tasks = [];

  UserModel? _currentUser;

  String get userName => _currentUser?.name ?? 'User';
  String? get profileImageUrl => _currentUser?.profileImageUrl;
  UserModel? get currentUser => _currentUser;

  //tracking refresh state
  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  HomeViewModel() {
    loadUserProfile();
    getTasks();
  }

  //loading user profile
  Future<void> loadUserProfile() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        debugPrint(' No user logged in');
        return;
      }
      log.d('loading profile for user: ${user.id}');

      final response = await _supabase
          .from('profiles')
          .select('id, email, name, profile_image_url, created_at')
          .eq('id', user.id)
          .maybeSingle();

      if (response == null) {
        log.w('No profile found for user');
        return;
      }

      _currentUser = UserModel.fromJson(response);

      log.d('Profile loaded: ${_currentUser.toString()}');
      notifyListeners();
    } catch (e) {
      log.e('Error loading profile: $e');
    }
  }

  /// Get tasks from Supabase
  Future<void> getTasks() async {
    setState(ViewState.busy);

    try {
      tasks = await _taskService.getAllTasks();
      log.d('Loaded ${tasks.length} tasks');
      setState(ViewState.idle);
    } catch (e) {
      log.e('Error loading tasks: $e');

      setState(ViewState.idle);
      tasks = [];
    }
  }

  /// Returns Future for RefreshIndicator
  Future<void> onRefresh() async {
    log.d('Pull-to-refresh triggered');
    _isRefreshing = true;
    notifyListeners();

    try {
      await getTasks();
      log.d('Refresh complete');
    } catch (e) {
      log.e('Error during refresh: $e');
    } finally {
      _isRefreshing = false;
      notifyListeners();
    }
  }

  /// Refresh tasks after adding new task
  Future<void> refreshTasks() async {
    log.d('Refreshing tasks after add...');
    await getTasks();
    notifyListeners();
  }

  // flip the task from complete to incomplete and vice versa
  Future<void> toggleIsCompleted(TaskModel task) async {
    final originalState = task.isCompleted;
    try {
      task.isCompleted = !task.isCompleted;
      notifyListeners();
      log.d('Toggling task: ${task.id} to ${task.isCompleted}');
      await _taskService.toggleTaskCompletion(task.id, task.isCompleted);
      log.d('Task toggled successfully');
    } catch (e) {
      log.d('Error toggling task: $e');
      task.isCompleted = originalState;
      notifyListeners();
    }
  }

  /// Delete a task
  Future<void> deleteTask(BuildContext context, TaskModel task) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Are you sure you want to delete "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      log.d('Deleting task: ${task.id}');
      await _taskService.deleteTask(task.id);
      tasks.removeWhere((t) => t.id == task.id);
      notifyListeners();
      log.d('Task deleted successfully');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Task "${task.title}" deleted'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Undo',
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
        );
      }
    } catch (e) {
      log.e(' Error deleting task: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete task: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  //logout
  Future<void> logout(BuildContext context) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.logoutTitle),
        content: Text(AppStrings.logoutMessage),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: Text(AppStrings.logoutCancel),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            child: Text(
              AppStrings.logoutTitle,
              style: TextStyle(color: Colors.red),
            ),
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
