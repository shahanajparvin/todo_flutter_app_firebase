
import 'package:injectable/injectable.dart';
import 'package:todo_app/domain/entities/firebase_response.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/domain/usecases/todo_usecase.dart';


@Injectable()
class GetTasksUseCase
    extends TodoUseCase<String, Response<List<Task>>> {
  GetTasksUseCase({required super.repository});

  @override
  Future<Response<List<Task>>> execute() async {
    return repository.getTasks();
  }
}