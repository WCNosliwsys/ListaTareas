import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lista_tareas/features/tasks/presentation/widgets/task_filter_widget.dart';

void main() {
  testWidgets('TaskFilterWidget shows all filter options and selects correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(body: TaskFilterWidget()),
        ),
      ),
    );
    expect(find.text('Todas'), findsOneWidget);
    expect(find.text('Pendientes'), findsOneWidget);
    expect(find.text('Completadas'), findsOneWidget);
    await tester.tap(find.byWidgetPredicate(
      (widget) =>
          widget is ChoiceChip &&
          widget.label is Text &&
          (widget.label as Text).data == 'Pendientes',
    ));
    await tester.pump();

    final pendingChip = tester.widget<ChoiceChip>(find.byWidgetPredicate(
      (widget) =>
          widget is ChoiceChip &&
          widget.label is Text &&
          (widget.label as Text).data == 'Pendientes',
    ));
    expect(pendingChip.selected, true);
  });
}
