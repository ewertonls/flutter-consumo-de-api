import 'package:flutter_test/flutter_test.dart';
import 'package:todos/src/todo/domain/adapters/todo_adapter.dart';
import 'package:todos/src/todo/domain/errors/todo_format_exception.dart';
import 'package:todos/src/todo/domain/models/todo_model.dart';

void main() {
  test('fromJson returns a TodoModel', () {
    const json = '''
      {
          "userId": 1,
          "id": 2,
          "title": "quis ut nam facilis et officia qui",
          "completed": false
       }
      ''';

    final model = TodoAdapter.fromJson(json);

    expect(model, isA<TodoModel>());
  });

  test('fromJson throws TodoFormatException', () {
    const invalidJson = '''
      {1, 2}
      ''';

    expect(
      () => TodoAdapter.fromJson(invalidJson),
      throwsA(isA<TodoFormatException>()),
    );
  });
}
