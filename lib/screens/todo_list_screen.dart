import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/todo_service.dart';
import 'add_todo_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TodoService>().fetchTodos(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Task 4: context.select use for completed count
    final completedCount = context.select<TodoService, int>(
      (service) => service.completedCount,
    );

    final service = context.watch<TodoService>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Done: $completedCount'),
      ),
      body: service.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: service.todos.length,
              itemBuilder: (context, index) {
                final todo = service.todos[index];
                return ListTile(
                  title: Text(todo.title),
                  // Task 3: Check icon for true, circle for false
                  leading: Icon(
                    todo.completed
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: todo.completed ? Colors.green : Colors.grey,
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTodoScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}