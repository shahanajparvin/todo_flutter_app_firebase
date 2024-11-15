// Mocks generated by Mockito 5.4.4 from annotations
// in todo_app/test/presentation/task/bloc/task_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:todo_app/domain/entities/firebase_response.dart' as _i3;
import 'package:todo_app/domain/entities/task.dart' as _i6;
import 'package:todo_app/domain/repository/todo_repository.dart' as _i2;
import 'package:todo_app/domain/usecases/add_task_usecase.dart' as _i7;
import 'package:todo_app/domain/usecases/delete_task_usecase.dart' as _i9;
import 'package:todo_app/domain/usecases/get_tasks_usecase.dart' as _i4;
import 'package:todo_app/domain/usecases/update_iscompleted_usecase.dart'
    as _i10;
import 'package:todo_app/domain/usecases/update_task_usecase.dart' as _i8;

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

class _FakeTodoRepository_0 extends _i1.SmartFake
    implements _i2.TodoRepository {
  _FakeTodoRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_1<T> extends _i1.SmartFake implements _i3.Response<T> {
  _FakeResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetTasksUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTasksUseCase extends _i1.Mock implements _i4.GetTasksUseCase {
  MockGetTasksUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TodoRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTodoRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TodoRepository);

  @override
  _i5.Future<_i3.Response<List<_i6.Task>>> execute() => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue: _i5.Future<_i3.Response<List<_i6.Task>>>.value(
            _FakeResponse_1<List<_i6.Task>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Response<List<_i6.Task>>>);

  @override
  void setParam(String? param) => super.noSuchMethod(
        Invocation.method(
          #setParam,
          [param],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [AddTaskUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddTaskUseCase extends _i1.Mock implements _i7.AddTaskUseCase {
  MockAddTaskUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TodoRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTodoRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TodoRepository);

  @override
  _i5.Future<_i3.Response<_i6.Task>> execute() => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i5.Future<_i3.Response<_i6.Task>>.value(_FakeResponse_1<_i6.Task>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Response<_i6.Task>>);

  @override
  void setParam(_i6.Task? param) => super.noSuchMethod(
        Invocation.method(
          #setParam,
          [param],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [UpdateTaskUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdateTaskUseCase extends _i1.Mock implements _i8.UpdateTaskUseCase {
  MockUpdateTaskUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TodoRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTodoRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TodoRepository);

  @override
  _i5.Future<_i3.Response<_i6.Task>> execute() => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i5.Future<_i3.Response<_i6.Task>>.value(_FakeResponse_1<_i6.Task>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Response<_i6.Task>>);

  @override
  void setParam(Map<String, dynamic>? param) => super.noSuchMethod(
        Invocation.method(
          #setParam,
          [param],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [DeleteTaskUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteTaskUseCase extends _i1.Mock implements _i9.DeleteTaskUseCase {
  MockDeleteTaskUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TodoRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTodoRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TodoRepository);

  @override
  _i5.Future<_i3.Response<String>> execute() => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i5.Future<_i3.Response<String>>.value(_FakeResponse_1<String>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Response<String>>);

  @override
  void setParam(String? param) => super.noSuchMethod(
        Invocation.method(
          #setParam,
          [param],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [UpdateIsCompletedUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdateIsCompletedUseCase extends _i1.Mock
    implements _i10.UpdateIsCompletedUseCase {
  MockUpdateIsCompletedUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TodoRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTodoRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TodoRepository);

  @override
  _i5.Future<_i3.Response<String>> execute() => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue:
            _i5.Future<_i3.Response<String>>.value(_FakeResponse_1<String>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Response<String>>);

  @override
  void setParam(Map<String, dynamic>? param) => super.noSuchMethod(
        Invocation.method(
          #setParam,
          [param],
        ),
        returnValueForMissingStub: null,
      );
}
