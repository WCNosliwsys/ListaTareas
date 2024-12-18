import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'task_model.dart';
import '../domain/task_repository.dart';

class SharedPrefsTaskRepository implements TaskRepository {
  static const _tasksKey = 'tasks';
  @override
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

  @override
  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = jsonEncode(
      tasks.map((task) => {'id': task.id, 'title': task.title, 'isCompleted': task.isCompleted}).toList(),
    );
    await prefs.setString(_tasksKey, tasksJson);
  }
}
