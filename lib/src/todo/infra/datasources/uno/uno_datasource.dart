import 'package:uno/uno.dart';

import '../../../domain/adapters/todo_adapter.dart';
import '../../../domain/errors/todo_exception.dart';
import '../../../domain/models/todo_model.dart';
import '../todo_datasource_interface.dart';

class UnoDataSource implements ITodoDataSource {
  final Uno uno;

  const UnoDataSource(this.uno);

  @override
  Future<List<TodoModel>> getAll() async {
    try {
      final response =
          await uno.get('https://jsonplaceholder.typicode.com/todos/');
      final responseData = response.data as List;
      final todos = responseData.map((e) => TodoAdapter.fromMap(e)).toList();
      return todos;
    } on UnoError catch (e, s) {
      throw TodoException(e.message, s);
    }
  }
}
