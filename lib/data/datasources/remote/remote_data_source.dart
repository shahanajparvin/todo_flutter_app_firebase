
import 'package:todo_app/domain/entities/firebase_response.dart';
import 'package:todo_app/domain/entities/task.dart';


abstract class RemoteDataSource {


  Future<Response<List<Task>>> getTasks();

  Future<Response<Task>> addTask(Task task);

  Future<Response<Task>> updateTask(String id, Task task);

  Future<Response<String>> deleteTask(String id);

}
