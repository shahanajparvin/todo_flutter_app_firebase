
import 'package:todo_app/data/datasources/local/db/dbentities/task/task_entity.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:uuid/uuid.dart';



class DomainToDbTransformer {
  static List<TaskEntity>? transformTaskList(
      List<Task> modules) {
    try {
      return modules.map((e) {
        return TaskEntity(
            id:e.id!,
            title:e.title,
            description:e.description,
            category: e.category,
          date: e.date,
          time: e.time,
          isCompleted: e.isCompleted
          );
      }).toList();
    } on Exception catch (error, trace) {
      return [];
    }
  }

  static TaskEntity? transformTask(
      Task task, {bool isSynced = true}) {
    try {
      late String uniqueId;
      if(task.id==null){
        var uuid = Uuid();
        String uniqueId1 = uuid.v4();
        uniqueId = 'local-$uniqueId1';// Generates a unique ID
      }else{
        uniqueId = task.id!;
      }
      return TaskEntity(
          id:uniqueId,
          title:task.title,
          description:task.description,
          isCompleted: task.isCompleted,
          category: task.category,
          date: task.date,
          time: task.time,
          isSynced: isSynced
      );
    } on Exception catch (error, trace) {
      return null;
    }
  }


}
