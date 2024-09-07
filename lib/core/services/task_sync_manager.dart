

import 'package:todo_app/core/services/task_sync_service.dart';
import 'package:todo_app/core/utils/internet_connection_checker.dart';
import 'package:todo_app/data/datasources/local/local_data_source.dart';
import 'package:todo_app/data/datasources/remote/remote_data_source.dart';

class TaskSyncUtil{

  static syncData({ required RemoteDataSource remoteDataSource, required LocalDataSource localDataSource, required InternetConnectionChecker connectionChecker}){
    TaskSyncManager taskSyncManager = TaskSyncManager(remoteDataSource: remoteDataSource, localDataSource: localDataSource, connectionChecker: connectionChecker);
    taskSyncManager.syncTasksAndFetchLatest();
  }
}