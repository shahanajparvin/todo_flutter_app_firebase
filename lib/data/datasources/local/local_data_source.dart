import 'package:todo_app/domain/entities/task.dart';

abstract class LocalDataSource {

  Future<List<Task>?> getTasks();

  Future<Task?> addTask(Task task);

  Future<Task?> updateTask(Task task);

  Future<String?> deleteTask(String id);

  Future<void> clearLatestData();

  Future<void> saveTasks(List<Task> tasks);

  Future<int> getLastDataUpdateTime();

  Future<List<Task>?> getUnsynchedTasks();

  Future<String?> updateIsCompleted(String id, bool isCompleted);

}