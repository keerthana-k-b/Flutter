import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tod_clean_architecture/domain/entities/todo.dart';
import 'package:tod_clean_architecture/presentation/bloc/todo_bloc.dart';
import 'package:tod_clean_architecture/presentation/bloc/todo_event.dart';
import 'package:tod_clean_architecture/presentation/bloc/todo_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Load existing todos
    context.read<TodoBloc>().add(LoadTodos());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //  UPDATE DIALOG
  void _showUpdateDialog(BuildContext context, Todo todo) {
    final editController = TextEditingController(text: todo.title);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title:  Text("Update Task"),
          content: TextField(
            controller: editController,
            decoration:  InputDecoration(
              hintText: "Enter new task",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:  Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<TodoBloc>().add(
                      UpdateTodoEvent(
                        Todo(
                          id: todo.id,
                          title: editController.text,
                        ),
                      ),
                    );

                Navigator.pop(context);
              },
              child:  Text("Update"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Todo - Clean Architecture"),
        backgroundColor: Colors.deepPurple,
      ),

      body: Column(
        children: [

          //  INPUT FIELD
          Padding(
            padding:  EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Enter Task",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon:  Icon(Icons.add),
                  onPressed: () {
                    final text = controller.text.trim();

                    if (text.isNotEmpty) {
                      context.read<TodoBloc>().add(
                            AddTodoEvent(
                              Todo(
                                id: DateTime.now().toString(),
                                title: text,
                              ),
                            ),
                          );

                      controller.clear();
                    }
                  },
                ),
              ),
            ),
          ),

          //  TODO LIST
          Expanded(
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {

                print("UI Todos Count: ${state.todos.length}");

                if (state.todos.isEmpty) {
                  return  Center(
                    child: Text("No tasks yet"),
                  );
                }

                return ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    final todo = state.todos[index];

                    return Card(
                      margin: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ListTile(
                        title: Text(todo.title),

                        //  DELETE
                        trailing: IconButton(
                          icon:  Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context
                                .read<TodoBloc>()
                                .add(DeleteTodoEvent(todo.id));
                          },
                        ),

                        //  UPDATE
                        onTap: () {
                          _showUpdateDialog(context, todo);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}