import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/core/constant/app_text.dart';
import 'package:todo_app/domain/entities/firebase_response.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/domain/usecases/add_task_usecase.dart';
import 'package:todo_app/domain/usecases/delete_task_usecase.dart';
import 'package:todo_app/domain/usecases/get_tasks_usecase.dart';
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
  final UpdateIsCompletedUseCase updateIsCompletedUseCase;

  TaskBloc(this.getTasksUseCase, this.addTaskUseCase, this.updateTaskUseCase,
      this.deleteTaskUseCase,
      this.updateIsCompletedUseCase) : super(TaskInitial()) {
    on<FetchTasks>(_onFetchTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<UpdateIsCompleted>(_onUpdateIsCompleted);
  }


  Future<void> _onFetchTasks(FetchTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      Response<List<Task>> response = await getTasksUseCase.execute();
      if (response is SuccessResponse<List<Task>>) {
        List<Task> taskList = response
            .data; // `.data` should be accessible here
        emit(TaskLoaded(tasks: taskList));
      } else {
        emit(TaskLoaded(tasks: []));
      }
    } catch (e) {

    }
  }



  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {

    try {
      List<Task> updatedTaskList = [];
      if (state is TaskLoaded) {
        updatedTaskList = List.from((state as TaskLoaded).tasks);
      }
      emit(TaskLoading());
      addTaskUseCase.setParam(event.task);
      Response<Task> response = await addTaskUseCase.execute();
      if (response is SuccessResponse<Task>) {
        Task newTask = response.data;
        if (updatedTaskList.isNotEmpty) {
          updatedTaskList.insert(0,newTask); // Add the new task to the list
          emit(TaskLoaded(tasks: updatedTaskList,
              message: AppConst.addSuccess
          ));
        } else {
          updatedTaskList.add(newTask); // Add the new task to the list
          emit(TaskLoaded(
            tasks: updatedTaskList,
            message: AppConst.addSuccess
          ));
        }
      } else {
        _triggerMessage(AppConst.addFail,emit);
      }
    } catch (e) {
      _triggerMessage(AppConst.addFail,emit);
    }
  }


  _triggerMessage(message,Emitter<TaskState> emit){
    if(state is TaskLoaded){
      emit((state as TaskLoaded).copyWith(
        message: message,
      ));
    }else{
      emit(TaskError(message));
    }
  }




  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    try {
      List<Task> updatedTaskList = [];
      if (state is TaskLoaded) {
        updatedTaskList = List.from((state as TaskLoaded).tasks);
      }
      emit(TaskLoading());
      updateTaskUseCase.setParam({'id': event.taskId, 'task': event.task});
      Response<Task> response = await updateTaskUseCase.execute();
      if (response is SuccessResponse<Task>) {
        Task updatedTask = response.data;
        if (updatedTaskList.isNotEmpty) {
          final taskIndex = updatedTaskList.indexWhere((task) =>
          task.id == event.taskId);
          if (taskIndex != -1) {
            updatedTaskList[taskIndex] =
                updatedTask; // Replace the old task with the updated task
          }
          emit(TaskLoaded(
              tasks: updatedTaskList, message: AppConst.updateSuccess));
        }
      } else {
        _triggerMessage(AppConst.updateFail,emit);
      }
    } catch (e) {
      _triggerMessage(AppConst.updateFail,emit);
    }
  }


  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    try {
      List<Task> updatedTaskList = [];
      if (state is TaskLoaded) {
        updatedTaskList = List.from((state as TaskLoaded).tasks);
      }
      emit(TaskLoading());
      deleteTaskUseCase.setParam(event.taskId);
      Response<String> response = await deleteTaskUseCase.execute();
      if (response is SuccessResponse<String>) {
        final deletedTaskId = response.data;
        if (updatedTaskList.isNotEmpty) {
          updatedTaskList.removeWhere((task) =>
          task.id == deletedTaskId);
          emit(TaskLoaded(tasks: updatedTaskList,message: AppConst.deleteSuccess));
        }
      } else {
        _triggerMessage(AppConst.deleteFail,emit);
      }
    } catch (e) {
      _triggerMessage(AppConst.deleteFail,emit);
    }
  }

  Future<void> _onUpdateIsCompleted(UpdateIsCompleted event,
      Emitter<TaskState> emit) async {
    updateIsCompletedUseCase.setParam({'id': event.taskId, 'isCompleted': event.isCompleted});
    try {
      List<Task> updatedTaskList = [];
      if (state is TaskLoaded) {
        updatedTaskList = List.from((state as TaskLoaded).tasks);
      }
      emit(TaskLoading());
      Response<String> response = await updateIsCompletedUseCase.execute();
      if (response is SuccessResponse<String>) {
        String updatedTaskId = event.taskId;
        bool isCompleted = event.isCompleted;
        if (updatedTaskId.isNotEmpty) {
          final taskIndex = updatedTaskList.indexWhere((task) =>
          task.id == updatedTaskId);
          if (taskIndex != -1) {
            updatedTaskList[taskIndex] =
                updatedTaskList[taskIndex].copyWith(isCompleted: isCompleted);
          }
          emit(TaskLoaded(tasks: updatedTaskList,message: AppConst.statusSuccess));
        }
      } else {
        if (response is ErrorResponse<String>) {
          _triggerMessage(AppConst.statusFail,emit);
        }
      }
    } catch (e) {
      _triggerMessage(AppConst.statusFail,emit);
    }
  }

  Future<void> taskLoadedInList(List<Task> taskList) async {
    emit(TaskLoaded(tasks: taskList));
  }


}
