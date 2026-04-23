import 'package:tod_clean_architecture/domain/entities/todo.dart';

abstract class TodoRepository {
  List<Todo> getTodos();

  void addTodo(Todo todo);

  void updateTodo(Todo todo);

  void deleteTodo(String id);
}