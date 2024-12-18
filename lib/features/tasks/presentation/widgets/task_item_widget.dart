import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/task_provider.dart';
import '../../data/task_model.dart';

class TaskItemWidget extends ConsumerWidget {
  final Task task;
  final Animation<double> animation;

  const TaskItemWidget({
    super.key,
    required this.task,
    required this.animation,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Checkbox(
            value: task.isCompleted,
            onChanged: (_) => ref.read(taskProvider.notifier).toggleTask(task.id),
          ),
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => ref.read(taskProvider.notifier).deleteTask(task.id),
          ),
        ),
      ),
    );
  }
}
