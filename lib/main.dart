import 'package:todo_app/presentation/screens/tasks_home.dart';
import 'package:todo_app/shared/ui/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/util/environment_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EnvironmentConfig.flavor = Flavor.dev;
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo app',
      // custom app theme data
      theme: AppTheme.getThemeData(context),
      home: const TasksHomePage(),
    );
  }
}
