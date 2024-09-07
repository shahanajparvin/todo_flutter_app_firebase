import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:injectable/injectable.dart';

import 'package:todo_app/data/datasources/remote/remote_data_source.dart';
import 'package:todo_app/data/datasources/transformer/remote_to_domain_transformer.dart';
import 'package:todo_app/domain/entities/firebase_response.dart';
import 'package:todo_app/domain/entities/task.dart';

@LazySingleton(as: RemoteDataSource)
class RemoteDataSourceImpl extends RemoteDataSource {
  final FirebaseFirestore fireStore;

  RemoteDataSourceImpl(this.fireStore);

  @override
// Fetch tasks from Firestore
  Future<Response<List<Task>>> getTasks() async {
    try {
      final QuerySnapshot snapshot = await fireStore.collection('tasks').get();
      if (snapshot.docs.isNotEmpty) {
        return SuccessResponse<List<Task>>(data: transformToTask(snapshot));
      } else {
        return ErrorResponse<List<Task>>(errorMessage: 'No tasks found');
      }
    } catch (e) {
      // Handle Firestore-specific errors
      if (e is FirebaseException) {
        return ErrorResponse<List<Task>>(
          errorMessage: e.message ?? 'An error occurred while fetching tasks',
          exception: e,
        );
      } else {
        return ErrorResponse<List<Task>>(
          errorMessage: 'An unexpected error occurred',
          exception: e as Exception,
        );
      }
    }
  }

  Future<Response<Task>> addTask(Task task) async {
    try {


      DocumentReference docRef = await fireStore.collection('tasks').add(task.toMap());
      // Get the ID of the newly added document
      String newTaskId = docRef.id;

      Task newTask = Task(
        id: newTaskId, // Use the Firestore-generated ID
        title: task.title,
        description: task.description,
          category: task.category,
          isCompleted: task.isCompleted,
          date: task.date,
          time:task.time

      );
      return SuccessResponse<Task>(data: newTask);
    } catch (e) {
      return ErrorResponse<Task>(errorMessage: 'No tasks found');
    }
  }

  Future<Response<Task>> updateTask(String id, Task task) async {
    try {
      DocumentReference docRef = fireStore.collection('tasks').doc(id);
      await docRef.update(task.toMap());

      String newTaskId = docRef.id;

      Task newTask = Task(
        id: newTaskId, // Use the Firestore-generated ID
        title: task.title,
        description: task.description,
        category: task.category,
        isCompleted: task.isCompleted,
        date: task.date,
        time:task.time
      );
      return SuccessResponse<Task>(data: newTask);
    } catch (e) {
      return ErrorResponse<Task>(errorMessage: 'No tasks found');
    }
  }



  @override
  Future<Response<String>> deleteTask(String documentId) async {
    try {
      DocumentReference docRef = FirebaseFirestore.instance.collection('tasks').doc(documentId);
      await docRef.delete();
      return SuccessResponse<String>(data: documentId);
    } catch (e) {
      return ErrorResponse<String>(errorMessage: 'Error deleting task');
    }
  }

  @override
  Future<Response<String>> updateIsCompleted(String id, bool isCompleted) async {
    try {
      DocumentReference docRef = fireStore.collection('tasks').doc(id);
      await docRef.update({
        'isCompleted': isCompleted,
      });
      return SuccessResponse<String>(data: id);
    } catch (e) {
      return ErrorResponse<String>(errorMessage: 'Error updating status');
    }
  }



}
