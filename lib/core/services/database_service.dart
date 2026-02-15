import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskify/core/model/task_model.dart';

class DatabaseService {
  final _supabase = Supabase.instance.client;

  /// Get all tasks for the current user
  Future<List<TaskModel>> getAllTasks() async {
    try {
      debugPrint('Fetching tasks from Supabase...');
      final user = _supabase.auth.currentUser;

      if (user == null) {
        debugPrint('No user logged in');
        return [];
      }
      final response = await _supabase
          .from('tasks')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      debugPrint('Fetched ${response.length} tasks');

      final tasks = (response as List)
          .map((json) => TaskModel.fromJson(json))
          .toList();

      return tasks;
    } on PostgrestException catch (e) {
      debugPrint('Database error: ${e.message}');
      debugPrint('Code: ${e.code}');
      debugPrint(' Details: ${e.details}');
      rethrow; 
    } catch (e) {
      debugPrint('Unexpected error fetching tasks: $e');
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
      debugPrint('Adding task to Supabase...');

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

      debugPrint('Task added successfully');

      final task = TaskModel.fromJson(response);
      return task;
    } on PostgrestException catch (e) {
      debugPrint('Database error adding task: ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Error adding task: $e');
      rethrow;
    }
  }

  /// Update task completion status
  Future<void> toggleTaskCompletion(TaskModel task) async {
    try {
      debugPrint('Toggling task completion: ${task.id}');
      await _supabase
          .from('tasks')
          .update({'is_completed': !task.isCompleted})
          .eq('id', task.id);

      debugPrint('ask completion toggled');
    } on PostgrestException catch (e) {
      debugPrint('Error toggling task: ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Error: $e');
      rethrow;
    }
  }

  /// Update a task
  Future<TaskModel> updateTask(TaskModel task) async {
    try {
      debugPrint('Updating task: ${task.id}');

      final response = await _supabase
          .from('tasks')
          .update(task.toJson())
          .eq('id', task.id)
          .select()
          .single();

      debugPrint('Task updated successfully');

      return TaskModel.fromJson(response);
    } on PostgrestException catch (e) {
      debugPrint('Error updating task: ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Error: $e');
      rethrow;
    }
  }

  /// Delete a task
  Future<void> deleteTask(String taskId) async {
    try {
      debugPrint('Deleting task: $taskId');

      await _supabase.from('tasks').delete().eq('id', taskId);

      debugPrint('Task deleted successfully');
    } on PostgrestException catch (e) {
      debugPrint('Error deleting task: ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Error: $e');
      rethrow;
    }
  }
}
