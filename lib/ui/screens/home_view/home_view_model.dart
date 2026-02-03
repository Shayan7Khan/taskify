import 'package:taskify/core/base_class/base_view_model.dart';
import 'package:taskify/core/constants/enums.dart';
import 'package:taskify/core/dummy_tasks.dart';
import 'package:taskify/core/model/task_model.dart';

class HomeViewModel extends BaseViewModel {
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
}
