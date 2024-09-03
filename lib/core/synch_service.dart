

import 'package:injectable/injectable.dart';
import 'package:todo_app/core/utils/internet_connection_checker.dart';
import 'package:todo_app/data/datasources/local/local_data_source.dart';
import 'package:todo_app/data/datasources/remote/remote_data_source.dart';
import 'package:todo_app/domain/entities/firebase_response.dart';
import 'package:todo_app/domain/entities/task.dart';

class TaskSyncManager {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final InternetConnectionChecker connectionChecker;

  TaskSyncManager({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectionChecker,
});

  Future<Response<List<Task>>> syncTasksAndFetchLatest() async {
    if (await connectionChecker.isConnected()) {
      try {
       final unsyncedTasks = await localDataSource.getUnsynchedTasks();
       print('--------------unsyncedTasks '+ unsyncedTasks.toString());
        if (unsyncedTasks != null && unsyncedTasks.isNotEmpty) {
          for (Task task in unsyncedTasks) {
            if (task.id != null && task.id!.contains('local')) {
              await remoteDataSource.addTask(task);
            } else {
              await remoteDataSource.updateTask(task.id!, task);
            }
          }
        }

        // Step 3: Clear the local database's cache
        await localDataSource.clearLatestData();

        // Step 4: Fetch the latest data from the remote database
        final response = await remoteDataSource.getTasks();

        // Step 5: Cache the fetched data in the local database
        if (response is SuccessResponse<List<Task>>) {
          await localDataSource.saveTasks(response.data);
        }
        return response;
      } catch (e) {
        return ErrorResponse(errorMessage: e.toString());
      }
    }else{
      return ErrorResponse(errorMessage: 'No Internet Connection');
    }
  }
}



