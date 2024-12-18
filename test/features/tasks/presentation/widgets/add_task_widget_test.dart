import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lista_tareas/features/tasks/presentation/widgets/add_task_widget.dart';

void main() {
  testWidgets('AddTaskWidget adds a new task on button press', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: Scaffold(body: AddTaskWidget())),
      ),
    );
    final textField = find.byType(TextField);
    final addButton = find.byIcon(Icons.add_circle);
    await tester.enterText(textField, 'New Task');
    await tester.tap(addButton);
    await tester.pump();
    expect(find.text('New Task'), findsNothing);
  });
}
