import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String? id;
  final String title;
  final int? dateEpoch;
  final bool done;
  const TaskModel({
    required this.title,
    this.done = false,
    this.dateEpoch,
    this.id,
  });

  factory TaskModel.fromjson(Map<String, dynamic> json) {
    return TaskModel(
        id: json['_id'],
        title: json['title'],
        dateEpoch: json['date'],
        done: json['done'] ?? false);
  }
  factory TaskModel.changeDone(TaskModel model, bool value) {
    return TaskModel(
        title: model.title,
        id: model.id,
        dateEpoch: model.dateEpoch,
        done: value);
  }
  Map<String, dynamic> toJson(String uid) {
    return {'title': title, 'date': dateEpoch, 'user': uid, 'done': done};
  }

  @override
  List<Object?> get props => [id, title, dateEpoch, done];
}
