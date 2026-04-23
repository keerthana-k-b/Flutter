import 'package:equatable/equatable.dart';
import 'package:todo_bloc_app/model/todo_model.dart';

class TodoState extends Equatable{
  final List<TodoModel> todos;

  const TodoState({
    this.todos = const []
  });

  TodoState copyWith({List<TodoModel>? todos}){
    return TodoState(
      todos: todos ?? this.todos
      );
  }

@override
List<Object?> get props => [todos];

}