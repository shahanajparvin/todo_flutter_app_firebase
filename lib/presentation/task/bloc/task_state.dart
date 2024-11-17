import 'package:equatable/equatable.dart';
import 'package:todo_app/domain/entities/task.dart';


abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final String? message;  // Make nullable
  final bool isError;

  const TaskLoaded({
    this.tasks = const [],  // Default value
    this.message,          // Optional
    this.isError = false   // Default value
  });

  // Implement copyWith
  TaskLoaded copyWith({
    List<Task>? tasks,
    String? message,
    bool? isError,
  }) {
    return TaskLoaded(
      tasks: tasks ?? this.tasks,
      message: message ?? this.message,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [tasks, message, isError];  // Include all properties
}

class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object?> get props => [message];
}
