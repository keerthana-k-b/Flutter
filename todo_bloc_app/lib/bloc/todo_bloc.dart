import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_app/bloc/todo_event.dart';
import 'package:todo_bloc_app/bloc/todo_state.dart';
import 'package:todo_bloc_app/model/todo_model.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState>{

  TodoBloc(): super(TodoState()){

    //CREATE

    on<AddTodo>((event,emit){
      final updatedList = List<TodoModel>.from(state.todos)
        ..add(event.todo);

        emit(state.copyWith(todos: updatedList));
    });

    //UPDATE

    on<UpdateTodo>((event, emit){
      final updatedList = state.todos.map((todo){
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList();

      emit(state.copyWith(todos: updatedList));
    });

    //DELETE

    on<DeleteTodo>((event, emit){
      final updatedList = state.todos
         .where((todo) => todo.id != event.id)
         .toList();

         emit(state.copyWith(todos: updatedList));
    });
  }
}