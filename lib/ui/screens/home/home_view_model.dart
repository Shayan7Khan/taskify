import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/core/base_class/base_view_model.dart';
import 'package:taskify/core/constants/enums.dart';
import 'package:taskify/core/dummy_tasks.dart';
import 'package:taskify/core/model/task_model.dart';
import 'package:taskify/core/model/user_model.dart';
import 'package:taskify/core/services/auth_service.dart';
import 'package:taskify/core/strings/app_strings.dart';
import 'package:taskify/locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeViewModel extends BaseViewModel {
  final AuthService _authService = locator.get<AuthService>();
  final _supabase = Supabase.instance.client;

  List<TaskModel> tasks = [];

  String _userName = 'User';
  String? _profileImageUrl;

  String get userName => _userName;
  String? get profileImageUrl => _profileImageUrl;

  HomeViewModel() {
    getTasks();
    loadUserProfile();
  }

  /// Load user profile from database
  Future<void> loadUserProfile() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        debugPrint('No user logged in');
        return;
      }
      // Fetch profile from database
      final response = await _supabase
          .from('profiles')
          .select('name, profile_image_url')
          .eq('id', user.id)
          .single();

      final userProfile = UserModel.fromJson(response);
      _userName = userProfile.name;
      _profileImageUrl = userProfile.profileImageUrl;
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading profile: $e');
    }
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
