import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:todo_app/data/datasources/local/db/dao/task_dao.dart';
import 'package:todo_app/data/datasources/local/db/dbentities/task/task_entity.dart';
part 'app_database.g.dart';

@Database(version: 1, entities: [TaskEntity])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;
}