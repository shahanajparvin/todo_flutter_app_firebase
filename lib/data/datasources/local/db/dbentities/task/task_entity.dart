
import 'package:floor/floor.dart';
import 'package:todo_app/core/constant/app_text.dart';

@Entity(tableName: AppConst.tableName)
class TaskEntity {
  @primaryKey
  final String? id;
  final String title;
  final String description;
  final bool  isCompleted; // Indicates if the task is completed
  final String date; // Optional due date for the task
  final String time; // Optional due date for the task
  final String category;
  final bool isSynced;// Optional due date for the task

  TaskEntity({this.id, required this.title, required this.description, required this.isCompleted, required this.date, required this.time, required this.category, this.isSynced = true});
}


