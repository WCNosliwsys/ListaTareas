import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/task_model.dart';
import '../data/task_repository.dart';

class TaskNotifier extends StateNotifier<List<Task>> {
  final TaskRepository _repository;

  TaskNotifier(this._repository) : super([]) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    state = await _repository.loadTasks();
  }

  Future<void> _saveTasks() async {
    await _repository.saveTasks(state);
  }

  void addTask(String title) {
    state = [
      ...state,
      Task(id: DateTime.now().toString(), title: title),
    ];
    _saveTasks();
  }

  void toggleTask(String id) {
    state = state.map((task) {
      if (task.id == id) {
        return task.copyWith(isCompleted: !task.isCompleted);
      }
      return task;
    }).toList();
    _saveTasks();
  }

  void deleteTask(String id) {
    state = state.where((task) => task.id != id).toList();
    _saveTasks();
  }
}
