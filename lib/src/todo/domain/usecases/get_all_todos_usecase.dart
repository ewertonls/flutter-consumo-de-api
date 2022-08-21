import '../../infra/repositories/todo_repository_interface.dart';
import '../models/todo_model.dart';

class GetAllTodosUsecase {
  final ITodoRepository repository;

  const GetAllTodosUsecase(this.repository);

  Future<List<TodoModel>> getAll() async {
    final todos = await repository.getAll();
    return todos;
  }
}
