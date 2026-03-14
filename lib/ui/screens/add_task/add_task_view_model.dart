import 'package:flutter/material.dart';
import 'package:taskify/core/base_class/base_view_model.dart';
import 'package:taskify/core/constants/enums/priority.dart';
import 'package:taskify/core/constants/enums/view_state.dart';
import 'package:taskify/core/services/database_service.dart';
import 'package:taskify/locator.dart';

class AddTaskViewModel extends BaseViewModel {
  final DatabaseService _taskService = locator<DatabaseService>(); // Add this

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  Priority _selectedPriority = Priority.low;
  Priority get selectedPriority => _selectedPriority;

  final List<Priority> priorities = Priority.values;

  void setPriority(Priority priority) {
    _selectedPriority = priority;
    notifyListeners();
  }

  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Task title is required';
    }
    if (value.trim().length < 3) {
      return 'Title must be at least 3 characters';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required';
    }
    if (value.trim().length < 5) {
      return 'Description must be at least 5 characters';
    }
    return null;
  }

  String? validateTime(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Time is required';
    }
    return null;
  }

  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF55847A)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final hour = picked.hour.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');
      timeController.text = '$hour:$minute';
      notifyListeners();
    }
  }

  /// Add task to Supabase
  Future<void> addTask(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    setState(ViewState.busy);
    try {
      await _taskService.addTask(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        time: timeController.text.trim(),
        priority: _selectedPriority.toJson(), 
      );
      debugPrint('Task added to Supabase');
      setState(ViewState.idle);
      if (context.mounted) {
        Navigator.pop(context, true);
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Task added successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error adding task: $e');
      setState(ViewState.idle);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    timeController.dispose();
    super.dispose();
  }
}
