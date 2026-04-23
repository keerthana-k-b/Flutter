import 'package:tod_clean_architecture/domain/repository/todo_repository.dart';

class DeleteTodo {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  void call(String id) {
    repository.deleteTodo(id);
  }
}