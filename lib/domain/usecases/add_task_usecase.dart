
import 'package:injectable/injectable.dart';
import 'package:todo_app/domain/entities/firebase_response.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/domain/usecases/todo_usecase.dart';


@Injectable()
class AddTaskUseCase
    extends TodoUseCase<Task, Response<Task>> {
  AddTaskUseCase({required super.repository});

  @override
  Future<Response<Task>> execute() async {
    return repository.addTask(getParam()!);
  }
}