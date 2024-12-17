import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tasks = [
      {'title': 'Comprar pan', 'isCompleted': false},
      {'title': 'Estudiar Riverpod', 'isCompleted': true},
      {'title': 'Enviar email', 'isCompleted': false},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Mis Tareas')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            leading: Checkbox(
              value: task['isCompleted'],
              onChanged: (value) {},
            ),
            title: Text(
              task['title']!,
              style: TextStyle(
                decoration: task['isCompleted']! ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
          );
        },
      ),
    );
  }
}
