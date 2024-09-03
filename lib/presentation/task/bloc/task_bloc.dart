import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/domain/entities/firebase_response.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/domain/usecases/add_task_usecase.dart';
import 'package:todo_app/domain/usecases/delete_task_usecase.dart';
import 'package:todo_app/domain/usecases/get_tasks_usecase.dart';
import 'package:todo_app/domain/usecases/get_unsynced_tsks_usecase.dart';
import 'package:todo_app/domain/usecases/update_iscompleted_usecase.dart';
import 'package:todo_app/domain/usecases/update_task_usecase.dart';
import 'task_event.dart';
import 'task_state.dart';

@Injectable()
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase getTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final GetUnsyncedTsksUsecase unSyncedTaskUseCase;
  final UpdateIsCompletedUseCase updateIsCompletedUseCase;

  TaskBloc(this.getTasksUseCase, this.addTaskUseCase, this.updateTaskUseCase, this.deleteTaskUseCase, this.unSyncedTaskUseCase, this.updateIsCompletedUseCase) : super(TaskInitial()) {
    on<FetchTasks>(_onFetchTasks);
    on<FetchUnsynchedTasks>(_onFetchUnSyncedTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<UpdateIsCompleted>(_onUpdateIsCompleted);
  }

  Future<void> _onFetchTasks(FetchTasks event, Emitter<TaskState> emit) async {
    print('--initial'+ event.toString());
    emit(TaskLoading());
    try {
      Response<List<Task>> response = await getTasksUseCase.execute();
      print('--------------response is FirebaseSuccessResponse '+ (response is SuccessResponse).toString());
      if (response is SuccessResponse<List<Task>>) {
        // Access the list of tasks from the success response
        List<Task> taskList = response.data; // `.data` should be accessible here

        // Now we can use taskList as needed
        taskList.forEach((task) {
          print(' Task ID: ${task.id},  Task Title: ${task.title}, Task Description: ${task.description}');
        });
        emit(TaskLoaded(taskList));
      } else {
        if (response is ErrorResponse<List<Task>>) {
          print('--------------error '+ response.errorMessage.toString());
          emit(TaskError(response.errorMessage.toString()));
        }
      }
    } catch (e) {
      emit(TaskError('Failed to fetch tasks.'));
    }
  }

  Future<void> _onFetchUnSyncedTasks(FetchUnsynchedTasks event, Emitter<TaskState> emit) async {

    try {
      Response<List<Task>> response = await unSyncedTaskUseCase.execute();
      print('--------------response '+ response.toString());
      if (response is SuccessResponse<List<Task>>) {
        // Access the list of tasks from the success response
        List<Task> taskList = response.data; // `.data` should be accessible here

        // Now we can use taskList as needed
        taskList.forEach((task) {
          debugPrint('unsynch Task ID: ${task.id}, Task Title: ${task.title}, Task Description: ${task.description}');
        });

        print('--------------taskList LENGTH '+ taskList.length.toString());
      } else {
        print('--------------error '+ response.toString());
      }
    } catch (e) {

    }
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    print('--task'+ event.task.toString());
    addTaskUseCase.setParam(event.task);
    try {
      Response<Task> response = await addTaskUseCase.execute();
      print('-------response '+response.toString());
      if (response is SuccessResponse<Task>) {
        Task newTask = response.data;
        Response<List<Task>> fetchResponse = await getTasksUseCase.execute();
        if (fetchResponse is SuccessResponse<List<Task>>) {
          List<Task> updatedTaskList = fetchResponse.data;
          emit(TaskLoaded(updatedTaskList)); // Emit the updated list of tasks
        } else {
          emit(TaskError('Failed to fetch updated tasks.'));
        }
      }
    } catch (e) {
      emit(TaskError('Failed to add task.'));
    }
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    print('-----------event id '+ event.taskId);
    updateTaskUseCase.setParam({'id':event.taskId,'task': event.task});
    try {
      Response<Task> response = await updateTaskUseCase.execute();
      if (response is SuccessResponse<Task>) {
        Task newTask = response.data;
        print('-----------event id after '+ newTask.id.toString());
        Response<List<Task>> fetchResponse = await getTasksUseCase.execute();
        if (fetchResponse is SuccessResponse<List<Task>>) {
          List<Task> updatedTaskList = fetchResponse.data;
          emit(TaskLoaded(updatedTaskList)); // Emit the updated list of tasks
        } else {
          emit(TaskError('Failed to fetch updated tasks.'));
        }
      }
    } catch (e) {
      emit(TaskError('Failed to add task.'));
    }
  }





  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    deleteTaskUseCase.setParam(event.taskId);
    try {
      Response<String> response = await deleteTaskUseCase.execute();
      if (response is SuccessResponse<String>) {
        String deletedId = response.data;
        Response<List<Task>> fetchResponse = await getTasksUseCase.execute();
        if (fetchResponse is SuccessResponse<List<Task>>) {
          List<Task> updatedTaskList = fetchResponse.data;
          emit(TaskLoaded(updatedTaskList)); // Emit the updated list of tasks
        } else {
          emit(TaskError('Failed to fetch updated tasks.'));
        }
      }
    } catch (e) {
      emit(TaskError('Failed to delete task.'));
    }
  }

  Future<void> _onUpdateIsCompleted(UpdateIsCompleted event, Emitter<TaskState> emit) async {
    updateIsCompletedUseCase.setParam({'id':event.taskId,'isCompleted': event.isCompleted});
    try {
      Response<String> response = await updateIsCompletedUseCase.execute();
      if (response is SuccessResponse<String>) {
        String deletedId = response.data;
        Response<List<Task>> fetchResponse = await getTasksUseCase.execute();
        if (fetchResponse is SuccessResponse<List<Task>>) {
          List<Task> updatedTaskList = fetchResponse.data;
          emit(TaskLoaded(updatedTaskList)); // Emit the updated list of tasks
        } else {
          emit(TaskError('Failed to fetch updated tasks.'));
        }
      }
    } catch (e) {
      emit(TaskError('Failed to delete task.'));
    }
  }
}
