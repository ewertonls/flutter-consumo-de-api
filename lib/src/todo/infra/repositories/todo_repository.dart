import '../../domain/errors/todo_exception.dart';
import '../../domain/models/todo_model.dart';
import '../datasources/todo_datasource_interface.dart';
import '../repositories/todo_repository_interface.dart';

class TodoRepository implements ITodoRepository {
  final ITodoDataSource datasource;

  const TodoRepository(this.datasource);

  @override
  Future<List<TodoModel>> getAll() async {
    List<TodoModel> todos;
    try {
      todos = await datasource.getAll();
    } on TodoException {
      rethrow;
    }
    return todos;
  }
}
