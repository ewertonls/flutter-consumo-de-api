import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/src/todo/domain/errors/todo_exception.dart';
import 'package:todos/src/todo/domain/models/todo_model.dart';
import 'package:todos/src/todo/infra/datasources/uno/uno_datasource.dart';
import 'package:todos/src/todo/infra/repositories/todo_repository.dart';
import 'package:uno/uno.dart';

import '../../../../data/json_response.dart';
import '../../../../mocks/mocks.dart';

void main() {
  test('getAll returns a List<TodoModel>', () async {
    final uno = UnoMock();

    final response = Response(
      headers: {},
      status: 200,
      request: RequestMock(),
      data: jsonResponse,
    );

    when(() => uno.get(any())).thenAnswer((_) => Future.value(response));

    final datasource = UnoDataSource(uno);

    final repository = TodoRepository(datasource);

    final result = await repository.getAll();

    expect(result, isA<List<TodoModel>>());
  });
  test('getAll throws a TodoException', () async {
    final uno = UnoMock();

    when(() => uno.get(any())).thenThrow(const UnoError('Not Found'));

    final datasource = UnoDataSource(uno);

    final repository = TodoRepository(datasource);

    expect(() => repository.getAll(), throwsA(isA<TodoException>()));
  });
}
