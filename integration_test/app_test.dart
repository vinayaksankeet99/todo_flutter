import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:todo_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Add task', (WidgetTester tester) async {
    // setup
    app.main();
    await tester.pumpAndSettle();

    // do
    for (int i = 0; i < 5; i++) {
      final addButton = find.byKey(const ValueKey('AddButton'));
      await tester.tap(addButton);
      await tester.pumpAndSettle();
      final textField = find.byKey(const ValueKey('TextField'));
      await tester.enterText(textField, 'Task $i');
      await Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      final sendButton = find.byKey(const ValueKey('SendButton'));
      await tester.tap(sendButton);
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
    }

    // test
    expect(find.text('Task 0'), findsOneWidget);
  });

  testWidgets('Update task', (WidgetTester tester) async {
    // setup
    app.main();
    await tester.pumpAndSettle();

    // do
    final taskTile = find.text('Task 0');
    await tester.tap(taskTile);
    await tester.pumpAndSettle();
    final textField = find.byKey(const ValueKey('TextField'));
    await tester.enterText(textField, 'Task 20');
    await Future.delayed(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    final sendButton = find.byKey(const ValueKey('SendButton'));
    await tester.tap(sendButton);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5));
    // test
    expect(find.text('Task 20'), findsOneWidget);
  });

  testWidgets('Delete task', (WidgetTester tester) async {
    // setup
    app.main();
    await tester.pumpAndSettle();

    // do
    final deleteButton = find.byKey(const ValueKey('Delete0'));
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

    // test
    expect(find.text('Task 20'), findsNothing);
  });
}
