import 'package:todo_app/presentation/screens/tasks_home.dart';
import 'package:todo_app/shared/ui/app_theme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // custom app theme data
      theme: AppTheme.getThemeData(context),
      home: const TasksHomePage(),
    );
  }
}
