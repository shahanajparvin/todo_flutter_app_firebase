import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
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

  group('TaskBloc', () {


    test('emits TaskLoading and TaskLoaded on successful task fetch', () async {

      when(mockGetTasksUseCase.execute())
          .thenAnswer((_) => Future.value(SuccessResponse<List<Task>>(data: tasks)));

      // Act
      taskBloc.add(FetchTasks());

      // Assert
      await expectLater(
        taskBloc.stream,
        emitsInOrder([TaskLoading(), TaskLoaded(tasks)]),
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
        emitsInOrder([TaskLoading(), TaskLoaded([])]),
      );
    });

    test('emits TaskLoaded with updated task list on add task', () async {
      // Arrange
      when(mockAddTaskUseCase.execute())
          .thenAnswer((_) => Future.value(SuccessResponse<Task>(data: newTask)));


      // Act
      taskBloc.add(AddTask(newTask));

      List<Task> newList = [];
      newList.add(newTask);

      // Asser;
      await expectLater(
        taskBloc.stream,
        emitsInOrder([TaskLoaded(newList)]),
      );
    });

/*    test('emits TaskLoaded with updated task list on delete task', () async {
      final remainingTasks = tasks.where((t) => t.id != '1').toList();

      when(mockDeleteTaskUseCase.execute(any))
          .thenAnswer((_) => Future.value(Response.success(null)));

      // Mock the getTasks call that happens after deleting
      when(mockGetTasksUseCase.execute())
          .thenAnswer((_) => Future.value(Response.success(remainingTasks)));

      // Act
      taskBloc.add(DeleteTask('1'));

      // Assert
      await expectLater(
        taskBloc.stream,
        emitsInOrder([TaskLoading(), TaskLoaded(remainingTasks)]),
      );
    });

    test('emits TaskLoaded with updated task on task update', () async {
      when(mockUpdateTaskUseCase.execute(any))
          .thenAnswer((_) => Future.value(Response.success(updatedTask)));

      // Mock the getTasks call that happens after updating
      when(mockGetTasksUseCase.execute())
          .thenAnswer((_) => Future.value(Response.success([updatedTask])));

      // Act
      taskBloc.add(UpdateTask('1', task));

      // Assert
      await expectLater(
        taskBloc.stream,
        emitsInOrder([TaskLoading(), TaskLoaded([updatedTask])]),
      );
    });

    test('emits TaskLoaded with updated task status on isCompleted update', () async {
      final updatedTask = task.copyWith(isCompleted: true);

      when(mockUpdateIsCompletedUseCase.execute(any))
          .thenAnswer((_) => Future.value(Response.success(true)));

      // Mock the getTasks call that happens after updating
      when(mockGetTasksUseCase.execute())
          .thenAnswer((_) => Future.value(Response.success([updatedTask])));

      // Act
      taskBloc.add(UpdateIsCompleted('1', true));

      // Assert
      await expectLater(
        taskBloc.stream,
        emitsInOrder([TaskLoading(), TaskLoaded([updatedTask])]),
      );
    });*/
  });
}