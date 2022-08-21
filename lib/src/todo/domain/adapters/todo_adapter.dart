import 'dart:convert';

import '../errors/todo_format_exception.dart';
import '../models/todo_model.dart';

class TodoAdapter {
  const TodoAdapter._();

  static TodoModel fromJson(String json) {
    final Map<String, dynamic> map;
    try {
      map = jsonDecode(json);
    } on FormatException catch (e, s) {
      throw TodoFormatException('Invalid json format: ${e.message}', s);
    }
    return fromMap(map);
  }

  static TodoModel fromMap(Map<String, dynamic> map) {
    final todo = TodoModel(
      userId: map['userId'],
      id: map['id'],
      title: map['title'],
      completed: map['completed'],
    );
    return todo;
  }
}
