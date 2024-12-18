// Mocks generated by Mockito 5.4.4 from annotations
// in todo_app/test/domain/usecase/usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:todo_app/domain/entities/firebase_response.dart' as _i2;
import 'package:todo_app/domain/entities/task.dart' as _i5;
import 'package:todo_app/domain/repository/todo_repository.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeResponse_0<T> extends _i1.SmartFake implements _i2.Response<T> {
  _FakeResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TodoRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTodoRepository extends _i1.Mock implements _i3.TodoRepository {
  MockTodoRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Response<List<_i5.Task>>> getTasks() => (super.noSuchMethod(
        Invocation.method(
          #getTasks,
          [],
        ),
        returnValue: _i4.Future<_i2.Response<List<_i5.Task>>>.value(
            _FakeResponse_0<List<_i5.Task>>(
          this,
          Invocation.method(
            #getTasks,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Response<List<_i5.Task>>>);

  @override
  _i4.Future<_i2.Response<List<_i5.Task>>> getUnsyncedTasks() =>
      (super.noSuchMethod(
        Invocation.method(
          #getUnsyncedTasks,
          [],
        ),
        returnValue: _i4.Future<_i2.Response<List<_i5.Task>>>.value(
            _FakeResponse_0<List<_i5.Task>>(
          this,
          Invocation.method(
            #getUnsyncedTasks,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Response<List<_i5.Task>>>);

  @override
  _i4.Future<_i2.Response<_i5.Task>> addTask(_i5.Task? task) =>
      (super.noSuchMethod(
        Invocation.method(
          #addTask,
          [task],
        ),
        returnValue:
            _i4.Future<_i2.Response<_i5.Task>>.value(_FakeResponse_0<_i5.Task>(
          this,
          Invocation.method(
            #addTask,
            [task],
          ),
        )),
      ) as _i4.Future<_i2.Response<_i5.Task>>);

  @override
  _i4.Future<_i2.Response<_i5.Task>> updateTask(Map<String, dynamic>? map) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateTask,
          [map],
        ),
        returnValue:
            _i4.Future<_i2.Response<_i5.Task>>.value(_FakeResponse_0<_i5.Task>(
          this,
          Invocation.method(
            #updateTask,
            [map],
          ),
        )),
      ) as _i4.Future<_i2.Response<_i5.Task>>);

  @override
  _i4.Future<_i2.Response<String>> deleteTask(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteTask,
          [id],
        ),
        returnValue:
            _i4.Future<_i2.Response<String>>.value(_FakeResponse_0<String>(
          this,
          Invocation.method(
            #deleteTask,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Response<String>>);

  @override
  _i4.Future<_i2.Response<String>> updateIsCompleted(
          Map<String, dynamic>? map) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateIsCompleted,
          [map],
        ),
        returnValue:
            _i4.Future<_i2.Response<String>>.value(_FakeResponse_0<String>(
          this,
          Invocation.method(
            #updateIsCompleted,
            [map],
          ),
        )),
      ) as _i4.Future<_i2.Response<String>>);
}
