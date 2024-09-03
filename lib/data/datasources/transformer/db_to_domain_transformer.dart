
import 'package:todo_app/data/datasources/local/db/dbentities/task/task_entity.dart';
import 'package:todo_app/domain/entities/task.dart';



class DbToDomainTransformer {
  static List<Task> transformTaskList(
      List<TaskEntity> dbModules) {
    try {
      return dbModules.map((e) {
        final task =  Task(
            id: e.id, // Use the Firestore-generated ID
            title: e.title,
            description: e.description,
            category: e.category,
            isCompleted: e.isCompleted,
            date: e.date,
            time:e.time
        );
        return task;
      }).toList();
    } on Exception catch (error, trace) {
      return [];
    }
  }

  static Task? transformTask(
      TaskEntity taskEntity) {
    try {
      final task = Task(
          id: taskEntity.id,
          title: taskEntity.title,
          description: taskEntity.description,
          category: taskEntity.category,
          isCompleted: taskEntity.isCompleted,
          date: taskEntity.date,
          time:taskEntity.time
      );
      return task;
    } on Exception catch (error, trace) {
      return null;
    }
  }
}
