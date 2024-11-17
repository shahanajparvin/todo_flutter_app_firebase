import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:todo_app/core/constant/app_text.dart';
import 'package:todo_app/domain/entities/firebase_response.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/domain/usecases/add_task_usecase.dart';
import 'package:todo_app/domain/usecases/delete_task_usecase.dart';
import 'package:todo_app/domain/usecases/get_tasks_usecase.dart';
import 'package:todo_app/domain/usecases/update_iscompleted_usecase.dart';
import 'package:todo_app/domain/usecases/update_task_usecase.dart';
import 'package:todo_app/presentation/task/bloc/task_bloc.dart';
import 'package:todo_app/presentation/task/bloc/task_event.dart';
import 'package:todo_app/presentation/task/bloc/task_state.dart';

import '../../../fakedata.dart';
import 'task_bloc_test.mocks.dart';

@GenerateMocks([
  GetTasksUseCase,
  AddTaskUseCase,
  UpdateTaskUseCase,
  DeleteTaskUseCase,
  UpdateIsCompletedUseCase
])
void main() {
  late TaskBloc taskBloc;
  late MockGetTasksUseCase mockGetTasksUseCase;
  late MockAddTaskUseCase mockAddTaskUseCase;
  late MockUpdateTaskUseCase mockUpdateTaskUseCase;
  late MockDeleteTaskUseCase mockDeleteTaskUseCase;
  late MockUpdateIsCompletedUseCase mockUpdateIsCompletedUseCase;

  setUp(() {
    mockGetTasksUseCase = MockGetTasksUseCase();
    mockAddTaskUseCase = MockAddTaskUseCase();
    mockUpdateTaskUseCase = MockUpdateTaskUseCase();
    mockDeleteTaskUseCase = MockDeleteTaskUseCase();
    mockUpdateIsCompletedUseCase = MockUpdateIsCompletedUseCase();


    taskBloc = TaskBloc(
        mockGetTasksUseCase,
        mockAddTaskUseCase,
        mockUpdateTaskUseCase,
        mockDeleteTaskUseCase,
        mockUpdateIsCompletedUseCase
    );
  });

  List<Task> updateTaskById(String id, Task updatedTask) {
    final index = tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      tasks[index] = updatedTask;
    }

    return tasks;
  }



  group('TaskBloc', () {


    test('emits TaskLoading and TaskLoaded on successful task fetch', () async {

      when(mockGetTasksUseCase.execute())
          .thenAnswer((_) => Future.value(SuccessResponse<List<Task>>(data: tasks)));

      // Act
      taskBloc.add(FetchTasks());

      // Assert
      await expectLater(
        taskBloc.stream,
        emitsInOrder([TaskLoading(), TaskLoaded(tasks:tasks)]),
      );
    });


    test('emits TaskLoading and TaskError on task fetch failure', () async {
      when(mockGetTasksUseCase.execute())
          .thenAnswer((_) => Future.value(ErrorResponse(errorMessage: 'Failed to fetch tasks')));

      // Act
      taskBloc.add(FetchTasks());

      // Assert
      await expectLater(
        taskBloc.stream,
        emitsInOrder([TaskLoading(), TaskLoaded(tasks:[])]),
      );
    });

    test('emits TaskLoading and TaskLoaded on add task', () async {

      when(mockAddTaskUseCase.execute())
          .thenAnswer((_) => Future.value(SuccessResponse<Task>(data: newTask)));

      taskBloc.add(AddTask(newTask));

      List<Task> newList = [];
      newList.add(newTask);

      await expectLater(
        taskBloc.stream,
        emitsInOrder([TaskLoading(), TaskLoaded(tasks: newList,message: AppConst.addSuccess)]),
      );
    });

    test('emits TaskLoading and TaskError on add task', () async {
      when(mockGetTasksUseCase.execute())
          .thenAnswer((_) => Future.value(ErrorResponse(errorMessage: 'Failed to add tasks')));

      taskBloc.add(AddTask(newTask));

      // Assert
      await expectLater(
        taskBloc.stream,
        emitsInOrder([TaskLoading(), TaskError(AppConst.addFail)]),
      );
    });

    test('emits TaskLoading and TaskLoaded on delete task', () async {

      taskBloc.taskLoadedInList(tasks);

      String taskId = '1';

      final remainingTasks = tasks.where((t) => t.id != taskId).toList();

      when(mockDeleteTaskUseCase.execute())
          .thenAnswer((_) => Future.value(SuccessResponse<String>(data: taskId)));

      taskBloc.add(DeleteTask(taskId));

      await expectLater(
        taskBloc.stream,
        emitsInOrder([TaskLoading(), TaskLoaded(tasks: remainingTasks,message: AppConst.deleteSuccess)]),
      );
    });

    test('emits TaskLoading and TaskError on delete task', () async {

      taskBloc.taskLoadedInList(tasks);

      String taskId = '1';

      when(mockDeleteTaskUseCase.execute())
          .thenAnswer((_) => Future.value(ErrorResponse<String>(errorMessage: AppConst.deleteFail)));

      taskBloc.add(DeleteTask(taskId));

      await expectLater(
        taskBloc.stream,
        emitsInOrder([TaskLoading(), TaskError(AppConst.deleteFail)]),
      );
    });

    test('emits TaskLoading and TaskLoaded on update task', () async {

      taskBloc.taskLoadedInList(tasks);

      String taskId = '1';

      when(mockUpdateTaskUseCase.execute())
          .thenAnswer((_) => Future.value(SuccessResponse<Task>(data: updatedTask)));

      taskBloc.add(UpdateTask(taskId, updatedTask));

      await expectLater(
        taskBloc.stream,
        emitsInOrder([TaskLoading(), TaskLoaded(tasks: updateTaskById(taskId, updatedTask),message: AppConst.updateSuccess)]),
      );
    });

    test('emits TaskLoading and TaskError on update task', () async {

      taskBloc.taskLoadedInList(tasks);

      String taskId = '1';

      when(mockUpdateTaskUseCase.execute())
          .thenAnswer((_) => Future.value(ErrorResponse<Task>(errorMessage: AppConst.updateFail)));

      taskBloc.add(UpdateTask(taskId, updatedTask));

      await expectLater(
        taskBloc.stream,
        emitsInOrder([TaskLoading(), TaskError(AppConst.updateFail)]),
      );
    });

  });
}