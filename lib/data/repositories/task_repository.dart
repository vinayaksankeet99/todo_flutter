import 'dart:convert';

import 'package:todo_app/data/model/task_model.dart';
import 'package:dio/dio.dart';

class TaskRepository {
  TaskRepository();

  final String _baseUrl = "http://192.168.1.4:8085/tasks";

  final String uid = "1234";

  Future<void> addTask({required TaskModel task}) async {
    try {
      final data = task.toJson(uid);
      await Dio()
          .post(
            _baseUrl,
            data: data,
          )
          .timeout(const Duration(seconds: 10));
    } catch (e) {
      throw Exception("Failed to add task");
    }
  }

  Future<List<TaskModel>> getTasks() async {
    try {
      final response = await Dio().get(
        _baseUrl,
        queryParameters: {"uid": uid},
      ).timeout(const Duration(seconds: 10));
      final res = List<TaskModel>.from(
        json.decode(response.data).map((e) => TaskModel.fromjson(e)),
      );
      return res;
    } catch (e) {
      throw Exception("Failed to load tasks");
    }
  }

  Future<void> updateTask({required TaskModel task}) async {
    try {
      final data = task.toJson(uid);
      await Dio().put(
        _baseUrl,
        data: data,
        queryParameters: {"id": task.id},
      ).timeout(const Duration(seconds: 10));
    } catch (e) {
      throw Exception("Failed to update task");
    }
  }

  Future<void> deleteTask({required TaskModel task}) async {
    try {
      await Dio().delete(
        _baseUrl,
        data: {'uid': uid},
        queryParameters: {"id": task.id},
      ).timeout(const Duration(seconds: 10));
    } catch (e) {
      throw Exception("Failed to delete task");
    }
  }
}
