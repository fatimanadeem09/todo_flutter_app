import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/todo_service.dart';
import 'screens/todo_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TodoService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const TodoListScreen(),
    );
  }
}