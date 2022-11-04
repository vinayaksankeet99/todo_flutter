part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<TaskModel> get props => [];
}

class GetTaskList extends TasksEvent {}

class AddTask extends TasksEvent {
  final TaskModel taskModel;
  const AddTask({required this.taskModel});
}

class DeleteTask extends TasksEvent {
  final TaskModel taskModel;
  const DeleteTask({required this.taskModel});
}

class UpdateTask extends TasksEvent {
  final TaskModel taskModel;
  const UpdateTask({required this.taskModel});
}
