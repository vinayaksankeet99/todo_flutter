part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  final List<TaskModel> taskList;
  const TasksState({required this.taskList});

  @override
  List<Object> get props => [taskList];
}

class TaskLoading extends TasksState {
  TaskLoading() : super(taskList: []);
}

class TaskLoaded extends TasksState {
  final List<TaskModel> taskList;
  const TaskLoaded({required this.taskList}) : super(taskList: taskList);
  @override
  List<Object> get props => [taskList];
}

class TaskError extends TasksState {
  final String message;
  TaskError({required this.message}) : super(taskList: []);
}
