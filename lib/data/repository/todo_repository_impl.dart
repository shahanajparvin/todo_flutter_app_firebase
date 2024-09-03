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
  Future<Response<List<Task>>> getTasks() async {
    /*if (await connectionChecker.isConnected()) {
      final response = await remoteDataSource.getTasks();
      print('-----------response ' + response.toString());
      return response;
    } else {
      final data = await localDataSource.getTasks();
      if (data == null) {
        return const ErrorResponse(
            errorMessage: "Please check your internet connection");
      }
      return SuccessResponse(data: data);
    }*/
    final data = await localDataSource.getTasks();
    if (data == null) {
      return const ErrorResponse(
          errorMessage: "Please check your internet connection");
    }
    return SuccessResponse(data: data);
  }

  @override
  Future<Response<Task>> addTask(Task task) async {
  /*  if (await connectionChecker.isConnected()) {
      final response = await remoteDataSource.addTask(task);
      print('-----------response ' + response.toString());
      return response;
    } else {
      final data = await localDataSource.addTask(task);
      if (data == null) {
        return const ErrorResponse(
            errorMessage: "Please check your internet connection");
      }
      return SuccessResponse(data: data);
    }*/

    final data = await localDataSource.addTask(task);
    print('-----------data ' + data.toString());
    if (data == null) {
      return const ErrorResponse(
          errorMessage: "Please check your internet connection");
    }
    return SuccessResponse(data: data);
  }

  @override
  Future<Response<Task>> updateTask(Map<String, dynamic> map) async {
    if (!(map['id'].contains('local'))&&await connectionChecker.isConnected()) {
      print('-----asdasdas');
      final response = await remoteDataSource.updateTask(
          map['id'], map['task']);
      print('-----------response ' + response.toString());
      return response;
    } else if(( map['id'].contains('local'))){
      final data = await localDataSource.updateTask(map['task']);
      if (data == null) {
        return const ErrorResponse(
            errorMessage: "Please check your internet connection");
      }
      return SuccessResponse(data: data);
    }
    return const ErrorResponse(
        errorMessage: "Task can not update");
 /*   final data = await localDataSource.updateTask(map['task']);
    if (data == null) {
      return const ErrorResponse(
          errorMessage: "Please check your internet connection");
    }
    return SuccessResponse(data: data);*/
  }

  @override
  Future<Response<String>> deleteTask(String id) async {
    print('-----------delete id  ' + id.toString());
    if (!(id.contains('local'))&&await connectionChecker.isConnected()) {
      final response = await remoteDataSource.deleteTask(id);
      print('-----------response ' + response.toString());
      return response;
    } else if((id.contains('local'))){
      final data = await localDataSource.deleteTask(id);
      print('----------data '+data.toString());
      if (data == null) {
        return const ErrorResponse(
            errorMessage: "Task can not delete");
      }
      return SuccessResponse(data: data);
    }else{
      return const ErrorResponse(
          errorMessage: "Task can not delete");
    }
  }


  Future<void> _saveTaskList(Response<List<Task>>? dataResponse) async {
    if (dataResponse != null) {
      await localDataSource.clearLatestData();
      /* int lastTimeUpdate = DateTime.now().millisecondsSinceEpoch;
      await localDataSource.updateLastDataUpdateTime(lastTimeUpdate);*/

      print('-------------data saved ' +
          (dataResponse is SuccessResponse).toString());
      if (dataResponse is SuccessResponse<List<Task>>) {
        List<Task> taskList = dataResponse
            .data; // `.data` should be accessible here
        taskList.forEach((task) {
          debugPrint('Task Title: ${task.title}, Task Description: ${task
              .description}');
        });
        await localDataSource.saveTasks(taskList);
        print("-------------data saved  successfully");
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

   /* if (!(id.contains('local'))&&await connectionChecker.isConnected()) {
    final response = await remoteDataSource.u(id);
    print('-----------response ' + response.toString());
    return response;
    } else */if((id.contains('local'))){
    final data = await localDataSource.updateIsCompleted(id,isCompleted);
    print('----------data '+data.toString());
    if (data == null) {
    return const ErrorResponse(
    errorMessage: "Task can not update ");
    }
    return SuccessResponse(data: data);
    }else{
    return const ErrorResponse(
    errorMessage: "Task can not update ");
    }
  }
}
