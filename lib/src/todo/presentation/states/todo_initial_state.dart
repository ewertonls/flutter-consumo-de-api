import '../../domain/models/todo_model.dart';
import 'todo_state_interface.dart';

class InitialState implements TodoState {
  final List<TodoModel> todos;
  const InitialState(this.todos);
}
