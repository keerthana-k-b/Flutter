import 'package:equatable/equatable.dart';
import 'package:todo_bloc_app/model/todo_model.dart';

abstract class TodoEvent extends Equatable{
  @override
  List<Object?> get props => [];
}


//create 
class AddTodo extends TodoEvent {
  final TodoModel todo;

  AddTodo(this.todo);
}

//UPDATE
class UpdateTodo extends TodoEvent{
  final TodoModel todo;

  UpdateTodo(this.todo);
}

//DELETE
class DeleteTodo extends TodoEvent{
  final String id;

  DeleteTodo(this.id);
}

