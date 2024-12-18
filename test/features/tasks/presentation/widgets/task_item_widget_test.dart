import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lista_tareas/features/tasks/data/task_model.dart';
import 'package:lista_tareas/features/tasks/domain/task_provider.dart';
import 'package:lista_tareas/features/tasks/presentation/widgets/task_item_widget.dart';

void main() {
  testWidgets('TaskItemWidget toggles completion status and deletes task', (WidgetTester tester) async {
    final task = Task(id: '1', title: 'Test Task', isCompleted: false);
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.read(taskProvider.notifier).state = [task];
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Scaffold(
            body: TaskItemWidget(
              task: task,
              animation: kAlwaysCompleteAnimation,
            ),
          ),
        ),
      ),
    );
    expect(find.text('Test Task'), findsOneWidget);
    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    final updatedTask = container.read(taskProvider).firstWhere((t) => t.id == task.id);
    expect(updatedTask.isCompleted, true);
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();
    final tasks = container.read(taskProvider);
    expect(tasks.any((t) => t.id == task.id), false);
  });
}
