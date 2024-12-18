import 'package:flutter_test/flutter_test.dart';
import 'package:lista_tareas/features/tasks/domain/task_notifier.dart';
import 'package:lista_tareas/features/tasks/data/task_model.dart';
import 'package:lista_tareas/features/tasks/domain/task_repository.dart';

class MockTaskRepository implements TaskRepository {
  @override
  Future<List<Task>> loadTasks() async => [];
  @override
  Future<void> saveTasks(List<Task> tasks) async {}
}

void main() {
  late TaskNotifier notifier;
  late MockTaskRepository repository;

  setUp(() {
    repository = MockTaskRepository();
    notifier = TaskNotifier(repository);
  });
  test('addTask adds a new task', () {
    notifier.addTask('New Task');
    expect(notifier.state.length, 1);
    expect(notifier.state[0].title, 'New Task');
  });
  test('toggleTask changes the task completion status', () {
    notifier.addTask('Test Task');
    final taskId = notifier.state[0].id;
    notifier.toggleTask(taskId);
    expect(notifier.state[0].isCompleted, true);
    notifier.toggleTask(taskId);
    expect(notifier.state[0].isCompleted, false);
  });
  test('deleteTask removes the task from the list', () {
    notifier.addTask('Task to Delete');
    final taskId = notifier.state[0].id;
    notifier.deleteTask(taskId);
    expect(notifier.state.isEmpty, true);
  });
}
