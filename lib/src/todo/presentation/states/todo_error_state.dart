import '../../domain/errors/todo_exception.dart';
import 'todo_state_interface.dart';

class ErrorState implements TodoState {
  final TodoException error;
  const ErrorState(this.error);
}
