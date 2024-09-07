
import 'package:injectable/injectable.dart';
import 'package:todo_app/domain/entities/firebase_response.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/domain/usecases/todo_usecase.dart';


@Injectable()
class DeleteTaskUseCase
    extends TodoUseCase<String, Response<String>> {
  DeleteTaskUseCase({required super.repository});

  @override
  Future<Response<String>> execute() async {
    return repository.deleteTask(getParam()!);
  }
}