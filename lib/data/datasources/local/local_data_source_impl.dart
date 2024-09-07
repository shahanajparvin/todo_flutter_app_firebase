import 'package:injectable/injectable.dart';
import 'package:todo_app/data/datasources/local/db/db_helper.dart';
import 'package:todo_app/data/datasources/local/db/dbentities/task/task_entity.dart';
import 'package:todo_app/data/datasources/local/local_data_source.dart';
import 'package:todo_app/data/datasources/transformer/db_to_domain_transformer.dart';
import 'package:todo_app/data/datasources/transformer/domain_to_db_transformer.dart';
import 'package:todo_app/domain/entities/task.dart';




@Singleton(as: LocalDataSource)
class LocalDataSourceImpl extends LocalDataSource {

  final DbHelper _dbHelper;

  LocalDataSourceImpl(this._dbHelper);

  @override
  Future<List<Task>?> getTasks() async {
    List<TaskEntity>? tasks = await _dbHelper.getTaskList();
    if (tasks == null || tasks.isEmpty) {
      return null;
    }
    return DbToDomainTransformer.transformTaskList(tasks);
  }


  @override
  Future<void> clearLatestData() async {
    await _dbHelper.clearLatestData();
  }

  @override
  Future<Task?> addTask(Task task) async {
    TaskEntity? taskEntity = DomainToDbTransformer.transformTask(task,isSynced: false);
    if (taskEntity != null) {
      try {
        await _dbHelper.addTask(taskEntity);
        return DbToDomainTransformer.transformTask(taskEntity);
      } on Exception catch (error, trace) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<String> deleteTask(String id) async {
    await _dbHelper.deleteTask(id);
    return id;
  }

  @override
  Future<Task?> updateTask(Task task) async {
    TaskEntity? taskEntity = DomainToDbTransformer.transformTask(task,isSynced: false);
    if (taskEntity != null) {
      await _dbHelper.updateTask(taskEntity);
      return DbToDomainTransformer.transformTask(taskEntity);
    }
    return null;
  }

  @override
  Future<void> saveTasks(List<Task> tasks) async {
    List<TaskEntity>? taskEntity = DomainToDbTransformer.transformTaskList(tasks);
    if (taskEntity != null) {
      await _dbHelper.saveTakList(taskEntity);
    }
  }

  @override
  Future<int> getLastDataUpdateTime() {
    // TODO: implement getLastDataUpdateTime
    throw UnimplementedError();
  }

  @override
  Future<List<Task>?> getUnsynchedTasks() async {
    List<TaskEntity>? tasks = await _dbHelper.getUnsyncedTasks();
    if (tasks == null || tasks.isEmpty) {
      return null;
    }
    return DbToDomainTransformer.transformTaskList(tasks);
  }

  @override
  Future<String?> updateIsCompleted(String id, bool isCompleted) async {
    await _dbHelper.updateIsCompleted(id,isCompleted);
    return id;
  }
}
