import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/data/datasources/local/local_data_source.dart';
import 'package:todo_app/data/datasources/remote/remote_data_source.dart';
import 'package:todo_app/domain/entities/firebase_response.dart';
import 'package:todo_app/domain/entities/task.dart';

import 'package:todo_app/domain/repository/todo_repository.dart';

import '../../core/utils/internet_connection_checker.dart';

@LazySingleton(as: TodoRepository)
class TodoRepositoryImpl extends TodoRepository {
  RemoteDataSource remoteDataSource;
  LocalDataSource localDataSource;
  InternetConnectionChecker connectionChecker;

  final String _defaultErrorMessage = "Something went wrong. Please try later.";

  TodoRepositoryImpl({required this.remoteDataSource,
    required this.localDataSource,
    required this.connectionChecker});

  @override
  Future<Response<Task>> addTask(Task task) async {
    if (await connectionChecker.isConnected()) {
      print('remoteDataSource '+ task.toString());
      final response = await remoteDataSource.addTask(task);
      if (response is SuccessResponse<Task>) {
        await localDataSource.addTask(response.data); // Store locally
      }
      return response;
    } else {
      final data = await localDataSource.addTask(task);
      if (data == null) {
        return const ErrorResponse(
            errorMessage: "Please check your internet connection");
      }
      return SuccessResponse(data: data);
    }
  }

  @override
  Future<Response<List<Task>>> getTasks() async {
    if (await connectionChecker.isConnected()) {
      final response = await remoteDataSource.getTasks();
      if (response is SuccessResponse<List<Task>>) {
        await _saveTaskList(response); // Store locally
      }
      return response;
    } else {
      final data = await localDataSource.getTasks();
      if (data == null) {
        return const ErrorResponse(
            errorMessage: "Please check your internet connection");
      }
      return SuccessResponse(data: data);
    }
  }




  @override
  Future<Response<Task>> updateTask(Map<String, dynamic> map) async {
    String id = map['id'];
    if (!(id.contains('local')) && await connectionChecker.isConnected()) {

      final response = await remoteDataSource.updateTask(
          map['id'], map['task']);

      // If the task was successfully updated to the remote source, also add it to the local data source for later offline access
      if (response is SuccessResponse<Task>) {
        await localDataSource.updateTask(map['task']); // Store locally
      }
      return response;
    } else {
      final data = await localDataSource.updateTask(map['task']);
      if (data == null) {
        return const ErrorResponse(
            errorMessage: "Please check your internet connection");
      }
      return SuccessResponse(data: data);
    }
  }

  @override
  Future<Response<String>> deleteTask(String id) async {
    // Check if it's a remote task and if the connection is available
    if (!(id.contains('local')) && await connectionChecker.isConnected()) {
      // Delete from the remote data source
      final remoteResponse = await remoteDataSource.deleteTask(id);

      // If successful on the remote source, try deleting it from the local source as well
      if (remoteResponse is SuccessResponse<String>) {
        await localDataSource.deleteTask(id);
      }

      return remoteResponse;
    }

    // If it's a local task or there is no internet, handle local deletion
    final localResponse = await localDataSource.deleteTask(id);
    // Handle the case where the local deletion failed
    if (localResponse == null) {
      return const ErrorResponse(errorMessage: "Task cannot be deleted");
    }

    return SuccessResponse(data: localResponse);
  }




  Future<void> _saveTaskList(Response<List<Task>>? dataResponse) async {
    if (dataResponse != null) {
      await localDataSource.clearLatestData();
      if (dataResponse is SuccessResponse<List<Task>>) {
        List<Task> taskList = dataResponse
            .data; // `.data` should be accessible here
        await localDataSource.saveTasks(taskList);
      }
    }
  }

  @override
  Future<Response<List<Task>>> getUnsyncedTasks() async {
    final data = await localDataSource.getUnsynchedTasks();
    if (data == null) {
      return const ErrorResponse(
          errorMessage: "Please check your internet connection");
    }
    return SuccessResponse(data: data);
  }

  @override
  Future<Response<String>> updateIsCompleted(Map<String, dynamic> map) async {
    String id = map['id'];
    bool isCompleted = map['isCompleted'];

    // Check if it's a remote task and if the connection is available
    if (!(id.contains('local')) && await connectionChecker.isConnected()) {
      // Update the remote data source
      final remoteResponse = await remoteDataSource.updateIsCompleted(id, isCompleted);

      // If successful on the remote source, update the local source as well
      if (remoteResponse is SuccessResponse<String>) {
        await localDataSource.updateIsCompleted(id, isCompleted);
      }

      return remoteResponse;
    }

    // If it's a local task or there is no internet, handle local update
    final localResponse = await localDataSource.updateIsCompleted(id, isCompleted);

    // Handle the case where the local update failed
    if (localResponse == null) {
      return const ErrorResponse(errorMessage: "Task cannot be updated");
    }

    return SuccessResponse(data: localResponse);
  }

}
