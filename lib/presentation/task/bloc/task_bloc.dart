import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/core/utils/app_alert_manager.dart';
import 'package:todo_app/core/utils/app_context.dart';
import 'package:todo_app/core/utils/app_easy_loading.dart';
import 'package:todo_app/core/utils/core_utils.dart';
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

  TaskBloc(this.getTasksUseCase, this.addTaskUseCase, this.updateTaskUseCase,
      this.deleteTaskUseCase, this.unSyncedTaskUseCase,
      this.updateIsCompletedUseCase) : super(TaskInitial()) {
    on<FetchTasks>(_onFetchTasks);
    on<FetchUnsynchedTasks>(_onFetchUnSyncedTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<UpdateIsCompleted>(_onUpdateIsCompleted);
  }


  Future<void> _onFetchTasks(FetchTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      Response<List<Task>> response = await getTasksUseCase.execute();
      print('-------response ' + response.toString());
      if (response is SuccessResponse<List<Task>>) {
        List<Task> taskList = response
            .data; // `.data` should be accessible here
        taskList.forEach((task) {
          print(' Task ID: ${task.id},  Task Title: ${task
              .title}, Task Description: ${task.description}');
        });
        emit(TaskLoaded(taskList));
      } else {
        emit(TaskLoaded([]));
      }
    } catch (e) {

    }
  }

  Future<void> _onFetchUnSyncedTasks(FetchUnsynchedTasks event,
      Emitter<TaskState> emit) async {
    try {
      Response<List<Task>> response = await unSyncedTaskUseCase.execute();
      if (response is SuccessResponse<List<Task>>) {
        List<Task> taskList = response
            .data; // `.data` should be accessible here
        taskList.forEach((task) {
          debugPrint('unsynch Task ID: ${task.id}, Task Title: ${task
              .title}, Task Description: ${task.description}');
        });
      }
    } catch (e) {

    }
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    showLoading();
    try {
      addTaskUseCase.setParam(event.task);
      Response<Task> response = await addTaskUseCase.execute();
      if (response is SuccessResponse<Task>) {
        Task newTask = response.data;
        final currentState = state;
        if (currentState is TaskLoaded) {
          List<Task> updatedTaskList = List.from(currentState.tasks);
          updatedTaskList.insert(0,newTask); // Add the new task to the list
          emit(TaskLoaded(updatedTaskList));
        } else {
          List<Task> updatedTaskList = [];
          updatedTaskList.insert(0,newTask); // Add the new task to the list
          emit(TaskLoaded(updatedTaskList));
        }
        dismissWithMessage(message: getContext().text.success_add,isError: false);
      } else {
        dismissWithMessage(message: getContext().text.fail_add);
      }
    } catch (e) {
      dismissWithMessage(message: getContext().text.fail_add);
    }
  }


  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    showLoading();
    try {
      updateTaskUseCase.setParam({'id': event.taskId, 'task': event.task});
      Response<Task> response = await updateTaskUseCase.execute();
      if (response is SuccessResponse<Task>) {
        Task updatedTask = response.data;
        final currentState = state;
        if (currentState is TaskLoaded) {
          List<Task> updatedTaskList = List.from(currentState.tasks);
          final taskIndex = updatedTaskList.indexWhere((task) =>
          task.id == event.taskId);
          if (taskIndex != -1) {
            updatedTaskList[taskIndex] =
                updatedTask; // Replace the old task with the updated task
          }
          emit(TaskLoaded(updatedTaskList));
        }
        dismissWithMessage(message: getContext().text.success_update,isError: false);
      } else {
        dismissWithMessage(message: getContext().text.fail_update);
      }
    } catch (e) {
      dismissWithMessage(message: getContext().text.fail_update);
    }
  }


  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    showLoading();
    try {
      deleteTaskUseCase.setParam(event.taskId);
      Response<String> response = await deleteTaskUseCase.execute();
      if (response is SuccessResponse<String>) {
        final deletedTaskId = response.data;
        final currentState = state;
        if (currentState is TaskLoaded) {
          List<Task> updatedTaskList = List.from(currentState.tasks);
          updatedTaskList.removeWhere((task) =>
          task.id == deletedTaskId); // Remove the deleted task
          emit(TaskLoaded(updatedTaskList));
        }
        dismissWithMessage(message: getContext().text.success_delete, isError: false);
      } else {
        dismissWithMessage(message: getContext().text.fail_delete);
      }
    } catch (e) {
      dismissWithMessage(message: getContext().text.fail_delete);
    }
  }

  Future<void> _onUpdateIsCompleted(UpdateIsCompleted event,
      Emitter<TaskState> emit) async {
    updateIsCompletedUseCase.setParam({'id': event.taskId, 'isCompleted': event.isCompleted});
    showLoading();
    try {
      Response<String> response = await updateIsCompletedUseCase.execute();
      if (response is SuccessResponse<String>) {
        dismissLoadingIndicator();
        String updatedTaskId = event.taskId;
        bool isCompleted = event.isCompleted;
        final currentState = state;
        if (currentState is TaskLoaded) {
          List<Task> updatedTaskList = List.from(
              currentState.tasks); // Copy the current task list
          final taskIndex = updatedTaskList.indexWhere((task) =>
          task.id == updatedTaskId);
          if (taskIndex != -1) {
            updatedTaskList[taskIndex] =
                updatedTaskList[taskIndex].copyWith(isCompleted: isCompleted);
          }
          emit(TaskLoaded(updatedTaskList));
        }
        dismissWithMessage(message: getContext().text.success_status, isError: false);
      } else {
        dismissLoadingIndicator();
        if (response is ErrorResponse<String>) {
          dismissWithMessage(message: getContext().text.fail_status);
        }
      }
    } catch (e) {
      dismissWithMessage(message: getContext().text.fail_status);
    }
  }

  dismissWithMessage({required String message, bool isError = true}) {
    dismissLoadingIndicator();
    showAlert(
        message: message,
        isError: isError
    );
  }

  showLoading() async {
    showLoadingIndicator();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  BuildContext getContext() {
    return AppContext.context;
  }
}
