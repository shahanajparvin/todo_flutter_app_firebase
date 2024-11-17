import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/domain/entities/firebase_response.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/domain/repository/todo_repository.dart';
import 'package:todo_app/domain/usecases/add_task_usecase.dart';
import 'package:todo_app/domain/usecases/delete_task_usecase.dart';
import 'package:todo_app/domain/usecases/get_tasks_usecase.dart';
import 'package:todo_app/domain/usecases/update_task_usecase.dart';



import '../../fakedata.dart';
import 'usecase_test.mocks.dart';

@GenerateMocks([TodoRepository])
void main() {
  late AddTaskUseCase addTaskUseCase;
  late UpdateTaskUseCase updateTaskUseCase;
  late MockTodoRepository mockRepository;
  late DeleteTaskUseCase deleteTaskUseCase;
  late GetTasksUseCase getTasksUseCase;

  setUp(() {
    mockRepository = MockTodoRepository();
    addTaskUseCase = AddTaskUseCase(repository: mockRepository);
    updateTaskUseCase = UpdateTaskUseCase(repository: mockRepository);
    deleteTaskUseCase = DeleteTaskUseCase(repository: mockRepository);
    getTasksUseCase = GetTasksUseCase(repository: mockRepository);
  });

  group('AddTaskUseCase Tests', () {
    test('should return Response<Task> when task is added successfully', () async {
      // Arrange

      final response = SuccessResponse(data: task);

      when(mockRepository.addTask(task)).thenAnswer((_) async => response);
      addTaskUseCase.setParam(task);

      // Act
      Response<Task> result = await addTaskUseCase.execute();

      // Assert
      expect(result, isA<Response<Task>>());
      expect((result as SuccessResponse).data, task);
      verify(mockRepository.addTask(task)).called(1);
    });

    test('should return error response when adding task fails', () async {
      // Arrange

      final response = ErrorResponse<Task>(errorMessage:'Failed to add task');

      when(mockRepository.addTask(task)).thenAnswer((_) async => response);
      addTaskUseCase.setParam(task);

      // Act
      final result = await addTaskUseCase.execute();

      // Assert
      expect(result, isA<ErrorResponse<Task>>());

      expect((result as ErrorResponse<Task>).errorMessage, 'Failed to add task');
      verify(mockRepository.addTask(task)).called(1);
    });
  });

  group('UpdateTaskUseCase Tests', () {
    test('should return Response<Task> when task is updated successfully', () async {
      // Arrange
      final params = {'id': '123', 'task': task};
      final response = SuccessResponse<Task>(data: task);

      when(mockRepository.updateTask(params)).thenAnswer((_) async => response);
      updateTaskUseCase.setParam(params);

      // Act
      final result = await updateTaskUseCase.execute();

      // Assert
      expect(result, isA<Response<Task>>());
      expect((result as SuccessResponse).data, task);
      verify(mockRepository.updateTask(params)).called(1);
    });

    test('should return error response when updating task fails', () async {
      // Arrange
      final params = {'id': '123', 'task': task};
      final response = ErrorResponse<Task>(errorMessage:'Failed to add task');


      when(mockRepository.updateTask(params)).thenAnswer((_) async => response);
      updateTaskUseCase.setParam(params);

      // Act
      final result = await updateTaskUseCase.execute();

      // Assert
      expect(result, isA<ErrorResponse<Task>>());

      expect((result as ErrorResponse<Task>).errorMessage, 'Failed to add task');
      verify(mockRepository.updateTask(params)).called(1);
    });
  });


  group('DeleteTaskUseCase Tests', () {
    test('should return Response<String> when task is deleted successfully', () async {
      // Arrange
      const taskId = '123';
      final response = SuccessResponse<String>(data: taskId);

      when(mockRepository.deleteTask(taskId)).thenAnswer((_) async => response);
      deleteTaskUseCase.setParam(taskId);

      // Act
      final result = await deleteTaskUseCase.execute();

      // Assert
      expect(result, isA<Response<String>>());
      expect((result as SuccessResponse).data, taskId);
      verify(mockRepository.deleteTask(taskId)).called(1);
    });

    test('should return error Response<String> when delete fails', () async {
      // Arrange
      const taskId = '123';
      final response = ErrorResponse<String>(errorMessage:'Failed to add task');

      when(mockRepository.deleteTask(taskId)).thenAnswer((_) async => response);
      deleteTaskUseCase.setParam(taskId);

      // Act
      final result = await deleteTaskUseCase.execute();

      // Assert
      expect(result, isA<Response<String>>());
      expect((result as ErrorResponse<String>).errorMessage, 'Failed to add task');
      verify(mockRepository.deleteTask(taskId)).called(1);
    });
  });

  group('GetTasksUseCase Tests', () {
    test('should return Response<List<Task>> when tasks are retrieved successfully', () async {
      // Arrange
      final tasks = [
       task,
       task
      ];
      final response = SuccessResponse<List<Task>>(data: tasks);

      when(mockRepository.getTasks()).thenAnswer((_) async => response);

      // Act
      final result = await getTasksUseCase.execute();

      // Assert
      expect(result, isA<Response<List<Task>>>());
      expect((result as SuccessResponse).data, tasks);
      verify(mockRepository.getTasks()).called(1);
    });


    test('should return error Response<List<Task>> when get tasks fails', () async {
      // Arrange
      final response = ErrorResponse<List<Task>>(errorMessage:'Failed to add task');

      when(mockRepository.getTasks()).thenAnswer((_) async => response);

      // Act
      final result = await getTasksUseCase.execute();

      // Assert
      expect(result, isA<Response<List<Task>>>());
      expect((result as ErrorResponse<List<Task>>).errorMessage, 'Failed to add task');
      verify(mockRepository.getTasks()).called(1);
    });


  });
}
