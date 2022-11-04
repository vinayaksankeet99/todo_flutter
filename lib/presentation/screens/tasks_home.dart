import 'package:flutter/material.dart';
import 'package:todo_app/bloc/tasks_bloc.dart';
import 'package:todo_app/data/model/task_model.dart';
import 'package:todo_app/shared/ui/app_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksHomePage extends StatefulWidget {
  const TasksHomePage({super.key});

  @override
  State<TasksHomePage> createState() => _TasksHomePageState();
}

class _TasksHomePageState extends State<TasksHomePage> {
  final TasksBloc _tasksBloc = TasksBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          key: const Key('AddButton'),
          onPressed: () async {},
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('To-do'),
        ),
        body: _buildTodoBuilder());
  }

  Widget _buildTodoBuilder() {
    return BlocProvider(
      create: (_) => _tasksBloc,
      child: BlocListener<TasksBloc, TasksState>(
          listener: (context, state) {},
          child: BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              if (state is TaskLoading) {
                return Container();
              } else if (state is TaskLoaded) {
                return _taskList(context, state.taskList);
              } else {
                return Container();
              }
            },
          )),
    );
  }

  Widget _taskList(BuildContext context, List<TaskModel> model) {
    return ListView.separated(
        itemCount: model.length,
        padding: const EdgeInsets.only(bottom: 100),
        separatorBuilder: (context, index) {
          return const Divider(
            color: AppColors.shimmer,
            indent: 24,
          );
        },
        itemBuilder: (context, index) {
          return const ListTile();
        });
  }
}
