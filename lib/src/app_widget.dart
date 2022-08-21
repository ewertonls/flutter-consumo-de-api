import 'package:flutter/material.dart';

import 'todo/presentation/pages/todos_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todos',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const TodosPage(title: 'Todos: Consumo de API'),
    );
  }
}
