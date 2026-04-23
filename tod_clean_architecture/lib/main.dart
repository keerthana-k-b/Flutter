import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tod_clean_architecture/data/datasource/todo_local_datasource.dart';
import 'package:tod_clean_architecture/data/repository/todo_repository_impl.dart';
import 'package:tod_clean_architecture/domain/usecases/add_todo.dart';
import 'package:tod_clean_architecture/domain/usecases/delete_todo.dart';
import 'package:tod_clean_architecture/domain/usecases/get_todo.dart';
import 'package:tod_clean_architecture/domain/usecases/update_todo.dart';
import 'package:tod_clean_architecture/presentation/bloc/todo_bloc.dart';
import 'package:tod_clean_architecture/presentation/screens/home_screen.dart';

void main() {
  //  Step 1: Create DataSource
  final dataSource = TodoLocalDataSource();

  //  Step 2: Create Repository with DataSource
  final repository = TodoRepositoryImpl(dataSource);

  runApp(
    MyApp(repository: repository),
  );
}

class MyApp extends StatelessWidget {
  final TodoRepositoryImpl repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: BlocProvider(
        create: (_) => TodoBloc(
          addTodo: AddTodo(repository),
          getTodos: GetTodos(repository),
          updateTodo: UpdateTodo(repository),
          deleteTodo: DeleteTodo(repository),
        ),
        child:  HomeScreen(),
      ),
    );
  }
}