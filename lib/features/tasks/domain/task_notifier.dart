import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/task_model.dart';

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]);

  void addTask(String title) {
    state = [
      ...state,
      Task(id: DateTime.now().toString(), title: title),
    ];
  }

  void toggleTask(String id) {
    state = state.map((task) {
      if (task.id == id) {
        return task.copyWith(isCompleted: !task.isCompleted);
      }
      return task;
    }).toList();
  }
}
