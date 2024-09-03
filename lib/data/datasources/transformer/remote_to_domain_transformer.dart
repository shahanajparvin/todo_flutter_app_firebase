
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/domain/entities/task.dart';


List<Task> transformToTask(QuerySnapshot snapshot) {
  final tasks = snapshot.docs.map((doc) => Task.fromDocument(doc)).toList();
  return tasks;
}


