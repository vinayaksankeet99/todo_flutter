import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/bloc/tasks_bloc.dart';
import 'package:todo_app/data/model/task_model.dart';
import 'package:todo_app/presentation/screens/add_task.dart';
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
  void initState() {
    _tasksBloc.add(GetTaskList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          key: const Key('AddButton'),
          onPressed: () async {
            addTaskFunction();
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('To-do'),
        ),
        body: _buildTodoBuilder());
  }

  void _showSnackBar({required String message, required Color color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(message),
      ),
    );
  }

  Widget _buildTodoBuilder() {
    return BlocProvider(
      create: (_) => _tasksBloc,
      child: BlocListener<TasksBloc, TasksState>(
        listener: (context, state) {
          if (state is TaskError) {
            _showSnackBar(
                message: state.message, color: AppColors.primaryLight);
          } else if (state is DeleteTaskError) {
            _showSnackBar(
                message: state.message, color: AppColors.primaryLight);
          } else if (state is AddTaskError) {
            _showSnackBar(
                message: state.message, color: AppColors.primaryLight);
          }
        },
        child: RefreshIndicator(onRefresh: () async {
          _tasksBloc.add(GetTaskList());
        }, child: BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              return _loadingWidget();
            } else if (state is TaskLoaded) {
              return _taskList(context, state.taskList);
            } else {
              return _errorWidget();
            }
          },
        )),
      ),
    );
  }

  Widget _taskList(BuildContext context, List<TaskModel> model) {
    final textTheme = Theme.of(context).textTheme;
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
          return ListTile(
              onTap: () {
                addTaskFunction(taskModel: model[index]);
              },
              leading: Checkbox(
                checkColor: Colors.white,
                value: model[index].done,
                shape: const CircleBorder(),
                onChanged: (bool? value) {
                  if (value != null) {
                    _tasksBloc.add(UpdateTask(
                        taskModel: TaskModel.changeDone(model[index], value)));
                  }
                },
              ),
              title: Text(model[index].title),
              subtitle: model[index].dateEpoch == null
                  ? null
                  : Row(children: [
                      const Icon(
                        Icons.calendar_today_sharp,
                        size: 12,
                        color: AppColors.primaryMedium,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        DateFormat('MMM dd').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                model[index].dateEpoch!)),
                        style: textTheme.subtitle2
                            ?.copyWith(color: AppColors.primaryMedium),
                      )
                    ]),
              trailing: IconButton(
                  key: Key('Delete$index'),
                  onPressed: () {
                    _tasksBloc.add(DeleteTask(taskModel: model[index]));
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: AppColors.border,
                  )));
        });
  }

  Widget _errorWidget() {
    final textTheme = Theme.of(context).textTheme;
    return Center(
        child: Container(
            decoration: BoxDecoration(
                color: AppColors.shimmer,
                borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 42),
            margin: const EdgeInsets.only(bottom: 100),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Failed to fetch tasks'),
                const SizedBox(
                  height: 16,
                ),
                IconButton(
                    onPressed: () {
                      _tasksBloc.add(GetTaskList());
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: AppColors.border,
                    )),
                Text(
                  'Retry',
                  style: textTheme.subtitle2?.copyWith(
                    color: AppColors.border,
                  ),
                )
              ],
            )));
  }

  Widget _loadingWidget() {
    return Center(
        child: Container(
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: AppColors.shimmer),
      padding: const EdgeInsets.all(12),
      child: const CircularProgressIndicator(
        strokeWidth: 2,
      ),
    ));
  }

  addTaskFunction({TaskModel? taskModel}) async {
    final addResult = await showModalBottomSheet<TaskModel>(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColors.background,
        builder: (BuildContext context) {
          return AddTaskSheet(
            taskModel: taskModel,
          );
        });
    if (addResult != null) {
      if (addResult.id == null) {
        // for adding a new task
        _tasksBloc.add(AddTask(taskModel: addResult));
      } else {
        // for updating an existing task. if the task contains an id, then it already exists, so we update
        _tasksBloc.add(UpdateTask(taskModel: addResult));
      }
    }
  }
}
