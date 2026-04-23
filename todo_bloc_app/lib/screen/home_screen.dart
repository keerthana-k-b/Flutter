import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_app/bloc/todo_bloc.dart';
import 'package:todo_bloc_app/bloc/todo_event.dart';
import 'package:todo_bloc_app/bloc/todo_state.dart';
import 'package:todo_bloc_app/model/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text("TodoBLoC"),
  backgroundColor: Colors.deepPurple,
),

      body: Column(
        children: [

          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Enter Task",
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: (){
                    final text = controller.text;

                    if(text.isNotEmpty){
                      context.read<TodoBloc>().add(
                        AddTodo(
                          TodoModel(
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

          //LIST

          Expanded(
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context,state){
                return ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index){
                    final todo = state.todos[index];

                    return ListTile(
                      title: Text(todo.title),

                      //DELETE
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: (){
                          context
                             .read<TodoBloc>()
                             .add(DeleteTodo(todo.id));
                      }, 
                     ),

                     //UPDATE
                     onTap: () {
  final editController = TextEditingController(text: todo.title);

  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text("Update Task"),
        content: TextField(
          controller: editController,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<TodoBloc>().add(
                UpdateTodo(
                  TodoModel(
                    id: todo.id,
                    title: editController.text,
                  ),
                ),
              );

              Navigator.pop(context);
            },
            child: Text("Update"),
          ),
        ],
      );
    },
  );
}
                    );
                  },
                );
              }
              ),
          ),
        ],
      ),
    );
  }
}