import 'package:taskify/core/model/task_model.dart';

class DummyTasks {
  static  List<TaskModel> dummyTasks = [
    TaskModel(
      id: 1,
      title: 'Wake up',
      description: 'Its morning wake up',
      isCompleted: false,
      time: '12:00 pm',
      priority: 'High',
    ),
    TaskModel(
      id: 2,
      title: 'Medicine time',
      description: 'Its medicine time',
      isCompleted: true,
      time: '5:00 am',
      priority: 'Medium',
    ),
    TaskModel(
      id: 3,
      title: 'Dog walking',
      description: 'Walk the dogs',
      isCompleted: false,
      time: '2:00 pm',
      priority: 'High',
    ),
    TaskModel(
      id: 4,
      title: 'Exercise',
      description: 'Its exercise time',
      isCompleted: false,
      time: '7:00 pm',
      priority: 'Low',
    ),

    TaskModel(
      id: 5,
      title: 'Sleep',
      description: 'Its Sleep time',
      isCompleted: true,
      time: '11:00 pm',
      priority: 'High',
    ),
  ];
}
