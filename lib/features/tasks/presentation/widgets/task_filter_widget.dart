import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/task_filter_notifier.dart';
import '../../domain/task_provider.dart';

class TaskFilterWidget extends ConsumerWidget {
  const TaskFilterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(taskFilterProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: TaskFilter.values.map((filter) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ChoiceChip(
              label: Text(
                filter == TaskFilter.all
                    ? 'Todas'
                    : filter == TaskFilter.pending
                        ? 'Pendientes'
                        : 'Completadas',
              ),
              selected: currentFilter == filter,
              onSelected: (_) {
                ref.read(taskFilterProvider.notifier).setFilter(filter);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
