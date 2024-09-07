

import 'package:todo_app/core/constant/app_text.dart';
import 'package:todo_app/core/constant/pref_keys.dart';
import 'package:todo_app/core/services/task_sync_manager.dart';
import 'package:todo_app/core/utils/internet_connection_checker.dart';
import 'package:todo_app/data/datasources/local/local_data_source.dart';
import 'package:todo_app/data/datasources/remote/remote_data_source.dart';
import 'package:workmanager/workmanager.dart';

class BackgroundTaskSycServices{

  static initService(){
    Workmanager().initialize(
      callbackDispatcher, // The top-level function that is called by the workmanager
    );
  }

  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) {
      print("Executing task: $task with inputData: $inputData");
      switch (task) {
        case AppConst.syncService:
          print("This is a simple periodic task");
          if(inputData!=null){
            Map <String, dynamic> inputValue= inputData;
            final RemoteDataSource remoteDataSource = inputValue[AppKey.remoteDataSource];
            final LocalDataSource localDataSource = inputValue[AppKey.localDataSource];
            final InternetConnectionChecker connectionChecker  = inputValue[AppKey.connectionChecker];
            TaskSyncUtil.syncData(remoteDataSource: remoteDataSource,localDataSource: localDataSource,connectionChecker: connectionChecker);
          }
          break;
      }
      return Future.value(true);
    });
  }

}