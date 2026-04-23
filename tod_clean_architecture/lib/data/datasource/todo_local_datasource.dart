import 'package:tod_clean_architecture/domain/entities/todo.dart';

class TodoLocalDataSource {
  final List<Todo> _todos = []; 

  List<Todo> getTodos() => List.from(_todos);

  void addTodo(Todo todo) {
    _todos.add(todo);
  }


  void updateTodo(Todo updatedTodo) {
    final index = _todos.indexWhere((t) => t.id == updatedTodo.id);
    if (index != -1) {
      _todos[index] = updatedTodo;
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((t) => t.id == id);
  }
}