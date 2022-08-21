class TodoException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  const TodoException(this.message, [this.stackTrace]);
}
