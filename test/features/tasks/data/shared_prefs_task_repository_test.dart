import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lista_tareas/features/tasks/data/shared_prefs_task_repository.dart';
import 'package:lista_tareas/features/tasks/data/task_model.dart';

void main() {
  late SharedPrefsTaskRepository repository;
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    repository = SharedPrefsTaskRepository();
  });
  test('loadTasks returns an empty list when no tasks are saved', () async {
    final tasks = await repository.loadTasks();
    expect(tasks, isEmpty);
  });
  test('saveTasks saves tasks and loadTasks retrieves them', () async {
    final taskList = [Task(id: '1', title: 'Test Task', isCompleted: false)];
    await repository.saveTasks(taskList);
    final loadedTasks = await repository.loadTasks();
    expect(loadedTasks.length, 1);
    expect(loadedTasks[0].id, '1');
    expect(loadedTasks[0].title, 'Test Task');
  });
}
