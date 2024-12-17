import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'task_model.dart';

class TaskRepository {
  static final TaskRepository _instance = TaskRepository._internal();

  factory TaskRepository() => _instance;

  TaskRepository._internal();

  static const _tasksKey = 'tasks';

  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString(_tasksKey);
    if (tasksJson != null) {
      final decoded = jsonDecode(tasksJson) as List<dynamic>;
      return decoded
          .map((task) => Task(
                id: task['id'],
                title: task['title'],
                isCompleted: task['isCompleted'],
              ))
          .toList();
    }
    return [];
  }

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = jsonEncode(
      tasks.map((task) => {'id': task.id, 'title': task.title, 'isCompleted': task.isCompleted}).toList(),
    );
    await prefs.setString(_tasksKey, tasksJson);
  }
}
