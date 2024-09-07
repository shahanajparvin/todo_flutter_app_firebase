
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/data/datasources/local/db/database_provider.dart';
import 'package:todo_app/data/datasources/local/db/dbentities/task/task_entity.dart';


@LazySingleton()
class DbHelper {
  final DatabaseProvider provider;

  const DbHelper(this.provider);

  Future<List<TaskEntity>?> getTaskList() async {

    final db = await provider.getDatabase();
    try {
      return await db.taskDao.getTasks() ?? [];
    } catch (e, trace) {
      return [];
    }
  }

  Future<List<TaskEntity>?> getUnsyncedTasks() async {

    final db = await provider.getDatabase();
    try {
      return await db.taskDao.getUnsyncedTasks() ?? [];
    } catch (e, trace) {
      return [];
    }
  }

  Future<void> saveTakList(List<TaskEntity> tasks) async {
    final db = await provider.getDatabase();
    try {
      return await db.taskDao.save(tasks);
    } catch (e, trace) {
    }
  }



  Future<TaskEntity?> getTaskById(String id) async {
    final db = await provider.getDatabase();
    try {
      return await db.taskDao.getTaskById(id) ;
    } catch (e, trace) {
      return null;
    }
  }


  Future<void> addTask(TaskEntity task) async {
    final db = await provider.getDatabase();
    try {
      await db.taskDao.insert(task);;
    } catch (e, trace) {
    }
  }


  Future<void> updateTask(TaskEntity task) async {
    final db = await provider.getDatabase();
    try {
      await db.taskDao.updateTask(task);;
    } catch (e, trace) {
    }
  }

  Future<void> deleteTask(String id) async {
    final db = await provider.getDatabase();
    try {
      await db.taskDao.deleteTaskById(id);;
    } catch (e, trace) {
    }
  }

  Future<void> updateIsCompleted(String id, bool isCompleted) async {
    final db = await provider.getDatabase();
    try {
      await db.taskDao.updateIsCompleted(id,isCompleted);;
    } catch (e, trace) {
    }
  }


  Future<void> clearLatestData() async {
    final db = await provider.getDatabase();
    try {
       await db.taskDao.deleteAll();
    } catch (e, trace) {
      debugPrint(e.toString());
    }
  }
}