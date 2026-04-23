import 'package:tod_clean_architecture/domain/entities/todo.dart';
import 'package:tod_clean_architecture/domain/repository/todo_repository.dart';

class GetTodos {
  final TodoRepository repository;

  GetTodos(this.repository);

  List<Todo> call() {
    return repository.getTodos();
  }
}