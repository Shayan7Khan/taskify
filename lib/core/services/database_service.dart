import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/logge_customizations/custom_logger.dart';
import 'package:taskify/core/model/task_model.dart';

class DatabaseService {
  final CustomLogger log = CustomLogger(className: 'Database Service');
  final _supabase = Supabase.instance.client;

  /// Get all tasks for the current user
  Future<List<TaskModel>> getAllTasks() async {
    try {
      log.d('Fetching tasks from Supabase...');
      final user = _supabase.auth.currentUser;

      if (user == null) {
        log.d('No user logged in');
        return [];
      }
      final response = await _supabase
          .from('tasks')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false);
      log.d('Fetched ${response.length} tasks');
      final tasks = (response as List)
          .map((json) => TaskModel.fromJson(json))
          .toList();

      return tasks;
    } on PostgrestException catch (e) {
      log.d('Database error: ${e.message}');
      log.d('Code: ${e.code}');
      log.d(' Details: ${e.details}');
      rethrow;
    } catch (e) {
      log.e('Unexpected error fetching tasks: $e');
      rethrow;
    }
  }

  /// Add a new task
  Future<TaskModel> addTask({
    required String title,
    required String description,
    required String time,
    required String priority,
  }) async {
    try {
      log.d('Adding task to Supabase...');

      final user = _supabase.auth.currentUser;
      if (user == null) {
        throw Exception('User must be logged in to add tasks');
      }
      final response = await _supabase
          .from('tasks')
          .insert({
            'user_id': user.id,
            'title': title,
            'description': description,
            'time': time,
            'priority': priority,
            'is_completed': false,
          })
          .select()
          .single();

      log.d('Task added successfully');

      final task = TaskModel.fromJson(response);
      return task;
    } on PostgrestException catch (e) {
      log.e('Database error adding task: ${e.message}');
      rethrow;
    } catch (e) {
      log.e('Error adding task: $e');
      rethrow;
    }
  }

  /// Update task completion status
  Future<void> toggleTaskCompletion(
    String taskId,
    bool newCompletionState,
  ) async {
    try {
      log.d('Updating task completion: $taskId to $newCompletionState');
      await _supabase
          .from('tasks')
          .update({'is_completed': newCompletionState})
          .eq('id', taskId);
      log.d('Task completion updated to $newCompletionState');
    } on PostgrestException catch (e) {
      log.e('Error updating task: ${e.message}');
      rethrow;
    } catch (e) {
      log.e('Error: $e');
      rethrow;
    }
  }

  /// Update a task
  Future<TaskModel> updateTask(TaskModel task) async {
    try {
      log.d('Updating task: ${task.id}');

      final response = await _supabase
          .from('tasks')
          .update(task.toJson())
          .eq('id', task.id)
          .select()
          .single();

      log.e('Task updated successfully');

      return TaskModel.fromJson(response);
    } on PostgrestException catch (e) {
      log.d('Error updating task: ${e.message}');
      rethrow;
    } catch (e) {
      log.e('Error: $e');
      rethrow;
    }
  }

  /// Delete a task
  Future<void> deleteTask(String taskId) async {
    try {
      log.d('Deleting task: $taskId');
      await _supabase.from('tasks').delete().eq('id', taskId);
      log.d('Task deleted successfully');
    } on PostgrestException catch (e) {
      log.d('Error deleting task: ${e.message}');
      rethrow;
    } catch (e) {
      log.e('Error: $e');
      rethrow;
    }
  }
}
