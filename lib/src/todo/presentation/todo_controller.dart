import 'dart:async';

import 'package:todos/src/todo/domain/errors/todo_exception.dart';
import 'package:todos/src/todo/domain/usecases/get_all_todos_usecase.dart';
import 'package:todos/src/todo/infra/repositories/todo_repository_interface.dart';
import 'package:todos/src/todo/presentation/states/todo_error_state.dart';
import 'package:todos/src/todo/presentation/states/todo_loading_state.dart';
import 'package:todos/src/todo/presentation/states/todo_state_interface.dart';
import 'package:todos/src/todo/presentation/states/todo_success_state.dart';

class TodoController {
  late final StreamController<TodoState> _controller;

  late final GetAllTodosUsecase getAllTodos;

  final ITodoRepository repository;
  TodoController(this.repository) {
    _controller = StreamController.broadcast();
    fetchTodos();
    getAllTodos = GetAllTodosUsecase(repository);
  }

  Stream<TodoState> get stream => _controller.stream;

  void fetchTodos() async {
    _controller.sink.add(const LoadingState());
    try {
      await Future.delayed(const Duration(seconds: 3));
      final todos = await getAllTodos.getAll();

      _controller.sink.add(SuccessState(todos));
    } on TodoException catch (e) {
      _controller.sink.add(ErrorState(e));
    }
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }
}
