import 'package:todo_app/domain/entities/firebase_response.dart';
import 'package:todo_app/domain/entities/task.dart';

abstract class TodoRepository {
  Future<Response<List<Task>>> getTasks();
  Future<Response<List<Task>>> getUnsyncedTasks();
  Future<Response<Task>> addTask(Task task);
  Future<Response<Task>> updateTask(Map<String, dynamic> map);
  Future<Response<String>> deleteTask(String id);
  Future<Response<String>> updateIsCompleted(Map<String, dynamic> map);
}
