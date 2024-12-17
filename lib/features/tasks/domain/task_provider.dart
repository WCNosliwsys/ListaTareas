import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'task_notifier.dart';
import '../data/task_model.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>(
  (ref) => TaskNotifier(),
);
