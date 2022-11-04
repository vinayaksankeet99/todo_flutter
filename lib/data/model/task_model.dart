import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String? id;
  final String title;
  const TaskModel({
    required this.title,
    this.id,
  });

  factory TaskModel.fromjson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'],
      title: json['title'],
    );
  }
  factory TaskModel.changeDone(TaskModel model, bool value) {
    return TaskModel(
      title: model.title,
      id: model.id,
    );
  }
  Map<String, dynamic> toJson(String uid) {
    return {
      'title': title,
      'user': uid,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
      ];
}

class TaskListModel {
  TaskListModel({required this.list});

  factory TaskListModel.fromJson(List parsedJson) {
    final list = parsedJson.map((value) {
      return TaskModel.fromjson(value);
    }).toList();
    return TaskListModel(list: list);
  }

  final List<TaskModel> list;
}
