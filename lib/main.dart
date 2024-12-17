import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tareas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TaskPage(),
    );
  }
}

class TaskPage extends ConsumerWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

/*     final List<Map<String, dynamic>> tasks = [
      {'title': 'Comprar pan', 'isCompleted': false},
      {'title': 'Estudiar Riverpod', 'isCompleted': true},
      {'title': 'Enviar email', 'isCompleted': false},
    ]; */

    return Scaffold(
      appBar: AppBar(title: const Text('Mis Tareas')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(taskProvider.notifier).addTask('Nueva tarea');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
