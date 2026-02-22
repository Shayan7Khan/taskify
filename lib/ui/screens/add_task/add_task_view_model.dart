import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/core/base_class/base_view_model.dart';
import 'package:taskify/core/constants/enums.dart';
import 'package:taskify/core/dummy_tasks.dart';

class AddTaskViewModel extends BaseViewModel {
  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  String _selectedPriority = 'low';
  String get selectedPriority => _selectedPriority;

  final List<String> priorities = ['low', 'medium', 'high'];

  void setPriority(String priority) {
    _selectedPriority = priority;
    notifyListeners();
  }

  /// Validate title
  String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Task title is required';
    }
    if (value.trim().length < 3) {
      return 'Title must be at least 3 characters';
    }
    return null;
  }

  /// Validate description
  String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Description is required';
    }
    if (value.trim().length < 5) {
      return 'Description must be at least 5 characters';
    }
    return null;
  }

  /// Validate time
  String? validateTime(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Time is required';
    }
    return null;
  }

  /// Pick time using time picker
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

  /// Add task to dummy data
  Future<void> addTask(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    setState(ViewState.busy);
    try {
      final maxId = DummyTasks.dummyTasks.isEmpty
          ? 0
          : DummyTasks.dummyTasks
                .map((task) => task['id'] as int)
                .reduce((a, b) => a > b ? a : b);

      // Create new task
      final newTask = {
        'id': maxId + 1,
        'title': titleController.text.trim(),
        'description': descriptionController.text.trim(),
        'isCompleted': false,
        'time': timeController.text.trim(),
        'priority': _selectedPriority,
      };

      DummyTasks.dummyTasks.add(newTask);
      debugPrint('✅ Task added: $newTask');

      setState(ViewState.idle);
      if (context.mounted) {
        context.pop(true); 
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
      debugPrint('❌ Error adding task: $e');
      setState(ViewState.idle);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
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
