import 'package:tod_clean_architecture/domain/entities/todo.dart';
import 'package:tod_clean_architecture/domain/repository/todo_repository.dart';

class UpdateTodo {
  final TodoRepository repository;

  UpdateTodo(this.repository);

  void call(Todo todo) {
    repository.updateTodo(todo);
  }
}