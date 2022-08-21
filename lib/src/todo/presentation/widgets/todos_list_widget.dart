import 'package:flutter/material.dart';

import '../states/todo_states.dart';
import '../todo_controller.dart';

class TodosListView extends StatelessWidget {
  const TodosListView({
    super.key,
    required this.controller,
  });

  final TodoController controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TodoState>(
      stream: controller.stream,
      builder: (context, snapshot) {
        const loading = CircularProgressIndicator.adaptive();
        Widget error;
        Widget child = loading;

        if (!snapshot.hasData || snapshot.data is LoadingState) {
          child = loading;
        }

        if (snapshot.data is ErrorState) {
          final message = (snapshot as ErrorState).error.message;

          error = _ErrorMessage(message: message);

          child = error;
        }

        if (snapshot.data is SuccessState) {
          final todos = (snapshot.data as SuccessState).todos;

          final listview = Material(
            color: Colors.white,
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return CheckboxListTile(
                  title: Text(todo.title),
                  value: todo.completed,
                  onChanged: (value) {},
                );
              },
            ),
          );

          child = listview;
        }

        return _BodySwitcher(child: child);
      },
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.tightFor(width: 300, height: 200),
      color: Colors.red,
      child: Text(message),
    );
  }
}

class _BodySwitcher extends StatelessWidget {
  const _BodySwitcher({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween(begin: const Offset(1, 0), end: const Offset(0, 0))
                .animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutSine),
            ),
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
