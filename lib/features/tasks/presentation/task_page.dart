import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/task_model.dart';
import '../domain/task_provider.dart';
import 'services/task_animation_services.dart';
import 'widgets/add_task_widget.dart';
import 'widgets/task_filter_widget.dart';
import 'widgets/task_item_widget.dart';

class TaskPage extends ConsumerStatefulWidget {
  const TaskPage({super.key});

  @override
  ConsumerState<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends ConsumerState<TaskPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late final TaskAnimationService _animationService = TaskAnimationService(_listKey);

/*   void _syncAnimatedList(List<Task> oldTasks, List<Task> newTasks) {
    final oldIds = oldTasks.map((task) => task.id).toList();
    final newIds = newTasks.map((task) => task.id).toList();

    for (int i = oldIds.length - 1; i >= 0; i--) {
      if (!newIds.contains(oldIds[i])) {
        _listKey.currentState?.removeItem(
          i,
          (context, animation) => TaskItemWidget(
            task: oldTasks[i],
            animation: animation,
          ),
          duration: const Duration(milliseconds: 300),
        );
      }
    }

    for (int i = 0; i < newIds.length; i++) {
      if (!oldIds.contains(newIds[i])) {
        _listKey.currentState?.insertItem(i);
      }
    }
  } */

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(filteredTasksProvider);

    ref.listen<List<Task>>(filteredTasksProvider, (previous, next) {
      if (previous != null) {
        _animationService.syncAnimatedList(previous, next);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mis Tareas',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: AddTaskWidget(),
          ),
          const TaskFilterWidget(),
          Expanded(
            child: tasks.isEmpty
                ? const Center(
                    key: ValueKey('empty_message'),
                    child: Text(
                      'No hay tareas',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : AnimatedList(
                    key: _listKey,
                    initialItemCount: tasks.length,
                    itemBuilder: (context, index, animation) {
                      return TaskItemWidget(
                        task: tasks[index],
                        animation: animation,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
