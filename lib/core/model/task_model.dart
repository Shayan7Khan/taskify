class TaskModel {
  final int id;
  final String title;
  final String description;
  bool isCompleted;
  final String time;
  final String priority;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.time,
    required this.priority,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      time: json['time'],
      priority: json['priority'],
    );
  }
}
