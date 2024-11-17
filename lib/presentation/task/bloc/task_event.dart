import 'package:equatable/equatable.dart';
import 'package:todo_app/domain/entities/task.dart';


abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class FetchTasks extends TaskEvent {}

class AddTask extends TaskEvent {
  final Task task;

  const AddTask(this.task);

  @override
  List<Object?> get props => [task];
}

class UpdateTask extends TaskEvent {
  final String taskId;
  final Task task;

  const UpdateTask(this.taskId,this.task);

  @override
  List<Object?> get props => [task];
}

class DeleteTask extends TaskEvent {
  final String taskId;

  const DeleteTask(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class UpdateIsCompleted extends TaskEvent {
  final String taskId;
  final bool isCompleted;

  const UpdateIsCompleted(this.taskId,this.isCompleted);

  @override
  List<Object?> get props => [taskId];
}

