import '../../domain/models/todo_model.dart';

abstract class ITodoRepository {
  Future<List<TodoModel>> getAll();
}
