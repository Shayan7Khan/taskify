import 'package:taskify/core/constants/enums/priority.dart';

class TaskModel {
  final String id; // Changed from int to String (UUID)
  final String userId; // New field
  final String title;
  final String description;
  bool isCompleted;
  final String time;
  final Priority priority;
  final DateTime createdAt; // New field
  final DateTime updatedAt; // New field

  TaskModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.time,
    required this.priority,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create TaskModel from Supabase JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String, // UUID from Supabase
      userId: json['user_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['is_completed'] as bool,
      time: json['time'] as String,
      priority: Priority.fromString(json['priority'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  /// Convert TaskModel to Supabase JSON (for insert/update)
  Map<String, dynamic> toJson() {
    return {
      // Don't include 'id' for inserts (Supabase auto-generates)
      'user_id': userId,
      'title': title,
      'description': description,
      'is_completed': isCompleted,
      'time': time,
      'priority': priority.toJson(),
      // Don't include created_at/updated_at (Supabase auto-manages)
    };
  }

  TaskModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    bool? isCompleted,
    String? time,
    Priority? priority,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      time: time ?? this.time,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, priority: ${priority.name}, isCompleted: $isCompleted)';
  }
}
