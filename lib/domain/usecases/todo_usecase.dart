import 'package:todo_app/domain/repository/todo_repository.dart';

abstract class TodoUseCase<T, R> {
  TodoUseCase({required this.repository});
  final TodoRepository repository;
  // ignore: unused_field
  T? _param;

  void setParam(T param) {
    this._param = param;
  }

  T? getParam() {
    return _param;
  }

  Future<R> execute();
}
