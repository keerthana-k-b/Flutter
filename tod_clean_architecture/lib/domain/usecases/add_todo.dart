import 'package:tod_clean_architecture/domain/entities/todo.dart';
import 'package:tod_clean_architecture/domain/repository/todo_repository.dart';

class AddTodo {
  final TodoRepository repository;

  AddTodo(this.repository);

  void call(Todo todo) {
    repository.addTodo(todo);
  }
}