import 'package:tod_clean_architecture/data/datasource/todo_local_datasource.dart';
import 'package:tod_clean_architecture/domain/entities/todo.dart';
import 'package:tod_clean_architecture/domain/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource dataSource;

  TodoRepositoryImpl(this.dataSource);

  @override
  List<Todo> getTodos() => dataSource.getTodos();

  @override
  void addTodo(Todo todo) {
    dataSource.addTodo(todo);
  }

  @override
  void updateTodo(Todo todo) {
    dataSource.updateTodo(todo);
  }

  @override
  void deleteTodo(String id) {
    dataSource.deleteTodo(id);
  }
}