class TodoModel {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  const TodoModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });
}
