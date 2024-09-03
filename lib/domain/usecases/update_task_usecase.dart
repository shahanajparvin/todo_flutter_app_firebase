
import 'package:injectable/injectable.dart';
import 'package:todo_app/domain/entities/firebase_response.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/domain/usecases/todo_usecase.dart';


@Injectable()
class UpdateTaskUseCase
    extends TodoUseCase<Map<String, dynamic>, Response<Task>> {
  UpdateTaskUseCase({required super.repository});

  @override
  Future<Response<Task>> execute() async {
    return repository.updateTask(getParam()!);
  }
}