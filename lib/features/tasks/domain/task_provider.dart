import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'task_notifier.dart';
import 'task_filter_notifier.dart';
import '../data/task_model.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>(
  (ref) => TaskNotifier(),
);
final taskFilterProvider = StateNotifierProvider<TaskFilterNotifier, TaskFilter>(
  (ref) => TaskFilterNotifier(),
);
final filteredTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(taskProvider);
  final filter = ref.watch(taskFilterProvider);

  switch (filter) {
    case TaskFilter.pending:
      return tasks.where((task) => !task.isCompleted).toList();
    case TaskFilter.completed:
      return tasks.where((task) => task.isCompleted).toList();
    case TaskFilter.all:
    default:
      return tasks;
  }
});
