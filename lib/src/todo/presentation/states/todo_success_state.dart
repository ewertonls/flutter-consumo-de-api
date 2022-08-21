import '../../domain/models/todo_model.dart';
import 'todo_state_interface.dart';

class SuccessState implements TodoState {
  final List<TodoModel> todos;
  const SuccessState(this.todos);
}
