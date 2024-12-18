import 'package:flutter/material.dart';

import '../../data/task_model.dart';
import '../widgets/task_item_widget.dart';

class TaskAnimationService {
  final GlobalKey<AnimatedListState> listKey;

  TaskAnimationService(this.listKey);

  void syncAnimatedList(List<Task> oldTasks, List<Task> newTasks) {
    final oldIds = oldTasks.map((task) => task.id).toList();
    final newIds = newTasks.map((task) => task.id).toList();

    for (int i = oldIds.length - 1; i >= 0; i--) {
      if (!newIds.contains(oldIds[i])) {
        final removedTask = oldTasks[i];
        listKey.currentState?.removeItem(
          i,
          (context, animation) => TaskItemWidget(
            task: removedTask,
            animation: animation,
          ),
          duration: const Duration(milliseconds: 300),
        );
      }
    }

    for (int i = 0; i < newIds.length; i++) {
      if (!oldIds.contains(newIds[i])) {
        listKey.currentState?.insertItem(i);
      }
    }
  }
}
