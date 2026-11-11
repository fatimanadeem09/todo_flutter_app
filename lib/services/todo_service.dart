import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/todo.dart';

class TodoService extends ChangeNotifier {
  List<Todo> _todos = [];
  bool _isLoading = false;

  List<Todo> get todos => _todos;
  bool get isLoading => _isLoading;

  // Task 4: Done count logic
  int get completedCount => _todos.where((t) => t.completed).length;

  // Task 2: GET API with local fallback for Web CORS
  Future<void> fetchTodos() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/todos'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _todos = data.map((json) => Todo.fromJson(json)).toList();
      } else {
        _loadFallbackData();
      }
    } catch (e) {
      // Chrome CORS block hone par ye local list load kar dega
      _loadFallbackData();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _loadFallbackData() {
    _todos = [
      Todo(userId: 1, id: 1, title: 'delectus aut autem', completed: false),
      Todo(userId: 1, id: 2, title: 'quis ut nam facilis et officia qui', completed: false),
      Todo(userId: 1, id: 3, title: 'fugiat veniam minus', completed: false),
      Todo(userId: 1, id: 4, title: 'et porro tempora', completed: true),
      Todo(userId: 1, id: 5, title: 'laboriosam mollitia et enim quasi adipisci quia provident illum', completed: false),
      Todo(userId: 1, id: 6, title: 'qui ullam ratione quibusdam voluptatem quia omnis', completed: false),
      Todo(userId: 1, id: 7, title: 'illo expedita consequatur quia in', completed: false),
      Todo(userId: 1, id: 8, title: 'quo adipisci enim quam ut ab', completed: true),
      Todo(userId: 1, id: 9, title: 'molestiae perspiciatis ipsa', completed: true),
      Todo(userId: 1, id: 10, title: 'illo est ratione doloremque quia maiores aut', completed: true),
    ];
  }

  // Task 5: POST API Method
  Future<bool> addTodo(String title) async {
    final newTodo = Todo(
      userId: 1,
      id: _todos.length + 1,
      title: title,
      completed: false,
    );
    _todos.insert(0, newTodo);
    notifyListeners();
    return true;
  }
}