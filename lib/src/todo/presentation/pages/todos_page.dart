import 'package:flutter/material.dart';
import 'package:uno/uno.dart';

import '../../infra/datasources/todo_datasource_interface.dart';
import '../../infra/datasources/uno/uno_datasource.dart';
import '../../infra/repositories/todo_repository.dart';
import '../../infra/repositories/todo_repository_interface.dart';
import '../todo_controller.dart';
import '../widgets/animated_reload_button_widget.dart';
import '../widgets/todos_list_widget.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({super.key, required this.title});

  final String title;

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  final uno = Uno();
  late final ITodoDataSource datasource;
  late final ITodoRepository repository;
  late final TodoController controller;
  @override
  void initState() {
    super.initState();

    datasource = UnoDataSource(uno);
    repository = TodoRepository(datasource);
    controller = TodoController(repository);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          AnimatedReloadButton(controller: controller),
        ],
      ),
      body: Center(
        child: TodosListView(
          controller: controller,
        ),
      ),
    );
  }
}
