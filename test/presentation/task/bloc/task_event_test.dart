import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/presentation/task/bloc/task_event.dart';

import '../../../fakedata.dart';

void main() {
  group('TaskEvent', () {
    test('FetchTasks should be an instance of TaskEvent', () {
      final taskEvent = FetchTasks();
      expect(taskEvent, isA<TaskEvent>());
    });

    test('AddTask should be an instance of TaskEvent and hold correct task', () {

      final taskEvent = AddTask(task);
      expect(taskEvent, isA<TaskEvent>());
      expect(taskEvent.task, task);
    });

    test('UpdateTask should be an instance of TaskEvent and hold correct taskId and task', () {

      final taskEvent = UpdateTask('1', task);
      expect(taskEvent, isA<TaskEvent>());
      expect(taskEvent.taskId, '1');
      expect(taskEvent.task, task);
    });

    test('DeleteTask should be an instance of TaskEvent and hold correct taskId', () {
      final taskEvent = DeleteTask('1');
      expect(taskEvent, isA<TaskEvent>());
      expect(taskEvent.taskId, '1');
    });

    test('UpdateIsCompleted should be an instance of TaskEvent and hold correct taskId and isCompleted', () {
      final taskEvent = UpdateIsCompleted('1', true);
      expect(taskEvent, isA<TaskEvent>());
      expect(taskEvent.taskId, '1');
      expect(taskEvent.isCompleted, true);
    });

    test('AddTask props should be correct', () {
      final taskEvent = AddTask(task);
      expect(taskEvent.props, [task]);
    });

    test('UpdateTask props should be correct', () {
      final taskEvent = UpdateTask('1', task);
      expect(taskEvent.props, [task]);
    });

    test('DeleteTask props should be correct', () {
      final taskEvent = DeleteTask('1');
      expect(taskEvent.props, ['1']);
    });

    test('UpdateIsCompleted props should be correct', () {
      final taskEvent = UpdateIsCompleted('1', true);
      expect(taskEvent.props, ['1']);
    });
  });
}
