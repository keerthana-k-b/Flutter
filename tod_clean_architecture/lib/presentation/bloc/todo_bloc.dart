import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tod_clean_architecture/domain/usecases/add_todo.dart';
import 'package:tod_clean_architecture/domain/usecases/delete_todo.dart';
import 'package:tod_clean_architecture/domain/usecases/get_todo.dart';
import 'package:tod_clean_architecture/domain/usecases/update_todo.dart';
import 'package:tod_clean_architecture/presentation/bloc/todo_event.dart';
import 'package:tod_clean_architecture/presentation/bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final AddTodo addTodo;
  final GetTodos getTodos;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;

  TodoBloc({
    required this.addTodo,
    required this.getTodos,
    required this.updateTodo,
    required this.deleteTodo,
  }) : super(const TodoState()) {

    on<LoadTodos>((event, emit) {
      emit(state.copyWith(
  todos: List.from(getTodos()),
));
    });

    on<AddTodoEvent>((event, emit) {
      addTodo(event.todo);

      final todos = getTodos(); 

      print("BLoC Todos Count: ${todos.length}");

      emit(state.copyWith(
  todos: List.from(getTodos()),
));
    });

    on<UpdateTodoEvent>((event, emit) {
      updateTodo(event.todo);

      final todos = getTodos(); 
      print("After Update: ${todos.length}");

      emit(state.copyWith(
  todos: List.from(getTodos()),
));
    });

    on<DeleteTodoEvent>((event, emit) {
      deleteTodo(event.id);

      final todos = getTodos(); 
      print("After Delete: ${todos.length}");

      emit(state.copyWith(
  todos: List.from(getTodos()),
));
    });
  }
}