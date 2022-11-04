import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/data/model/task_model.dart';
import 'package:todo_app/data/repositories/task_repository.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TaskLoading()) {
    final TaskRepository taskRepo = TaskRepository();
    on<GetTaskList>((event, emit) async {
      try {
        emit(TaskLoading());
        final taskList = await taskRepo.getTasks();
        emit(TaskLoaded(taskList: taskList));
      } catch (e) {
        emit(TaskError(message: 'Failed to fetch tasks'));
      }
    });

    on<AddTask>((event, emit) async {
      try {
        await taskRepo.addTask(task: event.taskModel);

        // emit(TaskLoading());
        final taskList = await taskRepo.getTasks();
        emit(TaskLoaded(taskList: taskList));
      } catch (e) {
        emit(TaskUpdateLoading(taskList: state.taskList));
        emit(AddTaskError(
            message: 'Failed to add task', taskList: state.taskList));
      }
    });

    on<DeleteTask>((event, emit) async {
      try {
        await taskRepo.deleteTask(task: event.taskModel);
        final taskList = await taskRepo.getTasks();
        emit(TaskLoaded(taskList: taskList));
      } catch (e) {
        emit(TaskUpdateLoading(taskList: state.taskList));
        emit(DeleteTaskError(
            message: 'Failed to delete task', taskList: state.taskList));
      }
    });
    on<UpdateTask>((event, emit) async {
      try {
        await taskRepo.updateTask(task: event.taskModel);
        final taskList = await taskRepo.getTasks();
        emit(TaskLoaded(taskList: taskList));
      } catch (e) {
        emit(TaskUpdateLoading(taskList: state.taskList));
        emit(AddTaskError(
            message: 'Failed to update task', taskList: state.taskList));
      }
    });
  }
}
