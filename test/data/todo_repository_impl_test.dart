import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/data/datasources/local/local_data_source.dart';
import 'package:todo_app/data/datasources/remote/remote_data_source.dart';
import 'package:todo_app/domain/entities/firebase_response.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/core/utils/internet_connection_checker.dart';
import 'package:todo_app/data/repository/todo_repository_impl.dart';

import '../fakedata.dart';
import 'todo_repository_impl_test.mocks.dart';


@GenerateMocks([
  RemoteDataSource,
  LocalDataSource,
  InternetConnectionChecker
])
void main() {
  late TodoRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockInternetConnectionChecker mockConnectionChecker;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockConnectionChecker = MockInternetConnectionChecker();
    final response = SuccessResponse<Task>(data: task);
    when(mockRemoteDataSource.addTask(argThat(isA<Task>()))).thenAnswer(
          (_) async => response,
    );
    repository = TodoRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      connectionChecker: mockConnectionChecker,
    );
  });

  group('getTasks', () {

    final successResponse = SuccessResponse<List<Task>>(data: tasks);

    test('should return tasks from remote when connected to the internet', () async {
      when(mockConnectionChecker.isConnected()).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getTasks()).thenAnswer((_) async => successResponse);

      final result = await repository.getTasks();

      expect(result, isA<SuccessResponse<List<Task>>>());
      expect(result, successResponse);
      verify(mockLocalDataSource.saveTasks(tasks));
    });

    test('should return tasks from local when not connected to the internet', () async {
      when(mockConnectionChecker.isConnected()).thenAnswer((_) async => false);
      when(mockLocalDataSource.getTasks()).thenAnswer((_) async => tasks);

      final result = await repository.getTasks();

      expect(result, isA<SuccessResponse<List<Task>>>());
      verifyNever(mockRemoteDataSource.getTasks());
    });

    test('should return error response when local data is null and no internet', () async {
      when(mockConnectionChecker.isConnected()).thenAnswer((_) async => false);
      when(mockLocalDataSource.getTasks()).thenAnswer((_) async => null);

      final result = await repository.getTasks();

      expect(result, isA<ErrorResponse<List<Task>>>());
    });
  });

  group('addTask', () {
    final successResponse = SuccessResponse<Task>(data: task);

    test('should add task to remote and local when connected', () async {
      when(mockConnectionChecker.isConnected()).thenAnswer((_) async => true);
      when(mockRemoteDataSource.addTask(task)).thenAnswer((_) async => successResponse);
      when(mockLocalDataSource.addTask(task)).thenAnswer((_) async => task);

      final result = await repository.addTask(task);


      expect(result, successResponse);
      expect(result, isA<SuccessResponse<Task>>());
      verify(mockLocalDataSource.addTask(task));
    });

    test('should add task to local only when not connected', () async {
      when(mockConnectionChecker.isConnected()).thenAnswer((_) async => false);
      when(mockLocalDataSource.addTask(task)).thenAnswer((_) async => task);

      final result = await repository.addTask(task);

      expect(result, isA<SuccessResponse<Task>>());
      verifyNever(mockRemoteDataSource.addTask(task));
    });

    test('should return error when unable to add task locally and no internet', () async {
      when(mockConnectionChecker.isConnected()).thenAnswer((_) async => false);
      when(mockLocalDataSource.addTask(task)).thenAnswer((_) async => null);

      final result = await repository.addTask(task);

      expect(result, isA<ErrorResponse<Task>>());
    });
  });

  group('addTask', () {
    final successResponse = SuccessResponse<Task>(data: task);

    test('should add task to remote and local when connected', () async {
      when(mockConnectionChecker.isConnected()).thenAnswer((_) async => true);
      when(mockRemoteDataSource.addTask(task)).thenAnswer((_) async => successResponse);
      when(mockLocalDataSource.addTask(task)).thenAnswer((_) async => task);

      final result = await repository.addTask(task);


      expect(result, successResponse);
      expect(result, isA<SuccessResponse<Task>>());
      verify(mockLocalDataSource.addTask(task));
    });

    test('should add task to local only when not connected', () async {
      when(mockConnectionChecker.isConnected()).thenAnswer((_) async => false);
      when(mockLocalDataSource.addTask(task)).thenAnswer((_) async => task);

      final result = await repository.addTask(task);

      expect(result, isA<SuccessResponse<Task>>());
      verifyNever(mockRemoteDataSource.addTask(task));
    });

    test('should return error when unable to add task locally and no internet', () async {
      when(mockConnectionChecker.isConnected()).thenAnswer((_) async => false);
      when(mockLocalDataSource.addTask(task)).thenAnswer((_) async => null);

      final result = await repository.addTask(task);

      expect(result, isA<ErrorResponse<Task>>());
    });
  });

  group('updateTask', () {

    final Map<String,dynamic> taskMap = {'id': '1', 'task': task};
    final successResponse = SuccessResponse(data: task);

    test('should update task remotely and locally when connected to the internet', () async {
      when(mockConnectionChecker.isConnected()).thenAnswer((_) async => true);
      when(mockRemoteDataSource.updateTask(taskMap['id'], taskMap['task']))
          .thenAnswer((_) async => successResponse);
      when(mockLocalDataSource.updateTask(taskMap['task']))
          .thenAnswer((_) async => task);

      final result = await repository.updateTask(taskMap);

      expect(result, successResponse);
      verify(mockRemoteDataSource.updateTask(taskMap['id'], taskMap['task']));
      verify(mockLocalDataSource.updateTask(taskMap['task']));
    });

    test('should update task locally when not connected to the internet', () async {
      when(mockConnectionChecker.isConnected()).thenAnswer((_) async => false);
      when(mockLocalDataSource.updateTask(taskMap['task']))
          .thenAnswer((_) async => task);

      final result = await repository.updateTask(taskMap);

      expect(result, isA<SuccessResponse<Task>>());
      verifyNever(mockRemoteDataSource.updateTask(taskMap['id'], taskMap['task']));
      verify(mockLocalDataSource.updateTask(taskMap['task']));
    });

    test('should return error response when task cannot be updated locally and no internet', () async {
      when(mockConnectionChecker.isConnected()).thenAnswer((_) async => false);
      when(mockLocalDataSource.updateTask(taskMap['task']))
          .thenAnswer((_) async => null);

      final result = await repository.updateTask(taskMap);

      expect(result, isA<ErrorResponse<Task>>());
    });
  });


  group('deleteTask', () {
    const taskId = '1';
    final successResponse = SuccessResponse(data: taskId);

    test('should delete task from remote and local when connected', () async {
      when(mockConnectionChecker.isConnected()).thenAnswer((_) async => true);
      when(mockRemoteDataSource.deleteTask(taskId)).thenAnswer((_) async => successResponse);
      when(mockLocalDataSource.deleteTask(taskId)).thenAnswer((_) async => taskId);

      final result = await repository.deleteTask(taskId);

      expect(result, successResponse);
      verify(mockLocalDataSource.deleteTask(taskId));
    });

    test('should delete task locally when not connected', () async {
      when(mockConnectionChecker.isConnected()).thenAnswer((_) async => false);
      when(mockLocalDataSource.deleteTask(taskId)).thenAnswer((_) async => taskId);

      final result = await repository.deleteTask(taskId);

      expect(result, isA<SuccessResponse<String>>());
      verifyNever(mockRemoteDataSource.deleteTask(taskId));
    });

    test('should return error when unable to delete task locally and no internet', () async {
      when(mockConnectionChecker.isConnected()).thenAnswer((_) async => false);
      when(mockLocalDataSource.deleteTask(taskId)).thenAnswer((_) async => null);

      final result = await repository.deleteTask(taskId);

      expect(result, isA<ErrorResponse<String>>());
    });
  });
}
