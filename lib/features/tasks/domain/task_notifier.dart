import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/task_model.dart';
import '../data/task_repository.dart';

class TaskNotifier extends StateNotifier<List<Task>> {
  final TaskRepository _repository;

  TaskNotifier(this._repository) : super([]) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final loadedTasks = await _repository.loadTasks();
    state = [...loadedTasks];
  }

  Future<void> _saveTasks() async {
    await _repository.saveTasks(state);
  }

  void addTask(String title) {
    final newTask = Task(id: DateTime.now().toString(), title: title);
    state = [...state, newTask];
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
