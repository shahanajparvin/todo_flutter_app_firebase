import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/presentation/task/bloc/task_state.dart';

import '../../../fakedata.dart';


void main() {
  group('TaskState', () {
    test('TaskInitial should be an instance of TaskState', () {
      final taskState = TaskInitial();
      expect(taskState, isA<TaskState>());
    });

    test('TaskLoading should be an instance of TaskState', () {
      final taskState = TaskLoading();
      expect(taskState, isA<TaskState>());
    });

    test('TaskLoaded should be an instance of TaskState', () {
      final taskState = TaskLoaded(tasks);
      expect(taskState, isA<TaskState>());
      expect(taskState.tasks, tasks);
    });

    test('TaskError should be an instance of TaskState', () {
      const errorMessage = 'Something went wrong';
      final taskState = TaskError(errorMessage);
      expect(taskState, isA<TaskState>());
      expect(taskState.message, errorMessage);
    });

    test('TaskLoaded props should be correct', () {
      final taskState = TaskLoaded(tasks);
      expect(taskState.props, [tasks]);
    });

    test('TaskError props should be correct', () {
      const errorMessage = 'Something went wrong';
      final taskState = TaskError(errorMessage);
      expect(taskState.props, [errorMessage]);
    });
  });
}
