import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todos/src/todo/domain/errors/todo_exception.dart';
import 'package:todos/src/todo/domain/models/todo_model.dart';
import 'package:todos/src/todo/infra/datasources/uno/uno_datasource.dart';
import 'package:uno/uno.dart';

import '../../../../../data/json_response.dart';
import '../../../../../mocks/mocks.dart';

void main() {
  test('getAll returns a List<TodoModel>', () async {
    final uno = UnoMock();

    final datasource = UnoDataSource(uno);

    final response = Response(
      headers: {},
      request: RequestMock(),
      status: 200,
      data: jsonResponse,
    );

    when(() => uno.get(any()))
        .thenAnswer((invocation) => Future.value(response));

    final result = await datasource.getAll();

    expect(result, isA<List<TodoModel>>());
  });

  test('getAll throws a TodoException', () {
    final uno = UnoMock();

    final datasource = UnoDataSource(uno);

    when(() => uno.get(any())).thenThrow(const UnoError('Not found'));

    expect(
      () => datasource.getAll(),
      throwsA(isA<TodoException>()),
    );
  });
}
