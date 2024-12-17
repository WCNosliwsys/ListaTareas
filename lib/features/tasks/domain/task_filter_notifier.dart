import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TaskFilter { all, pending, completed }

class TaskFilterNotifier extends StateNotifier<TaskFilter> {
  TaskFilterNotifier() : super(TaskFilter.all);

  void setFilter(TaskFilter newFilter) {
    state = newFilter;
  }
}
