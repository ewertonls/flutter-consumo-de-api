import 'package:flutter/material.dart';

import '../states/todo_states.dart';
import '../todo_controller.dart';

class AnimatedReloadButton extends StatefulWidget {
  const AnimatedReloadButton({
    super.key,
    required this.controller,
  });

  final TodoController controller;

  @override
  State<AnimatedReloadButton> createState() => _AnimatedReloadButtonState();
}

class _AnimatedReloadButtonState extends State<AnimatedReloadButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animation = Tween<double>(
      begin: 0,
      end: 3.1415 * 2,
    ).animate(animationController);

    widget.controller.stream.listen(_controllAnimation);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _controllAnimation(TodoState event) {
    if (event is LoadingState) {
      animationController.repeat();
    } else {
      animationController.animateTo(0, curve: Curves.easeOutSine);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return IconButton(
          onPressed: () {
            widget.controller.fetchTodos();
          },
          icon: Transform.rotate(
              origin: const Offset(0, 1),
              angle: -animation.value,
              child: const Icon(Icons.replay_outlined)),
        );
      },
    );
  }
}
