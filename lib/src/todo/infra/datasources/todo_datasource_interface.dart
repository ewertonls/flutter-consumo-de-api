import '../../domain/models/todo_model.dart';

abstract class ITodoDataSource {
  Future<List<TodoModel>> getAll();
}
