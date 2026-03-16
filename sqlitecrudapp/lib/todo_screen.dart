import 'package:flutter/material.dart';
import 'database/db_helper.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> todos = [];

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  // READ
  Future<void> loadTodos() async {
    final data = await DbHelper.getTodos();
    setState(() {
      todos = data;
    });
  }

  // CREATE
  Future<void> addTodo() async {
    if (_controller.text.isEmpty) return;

    await DbHelper.insertTodo(_controller.text);

    _controller.clear();
    loadTodos();
  }

  // UPDATE
  Future<void> updateTodo(int id) async {
    await DbHelper.updateTodo(id, _controller.text);

    _controller.clear();
    loadTodos();
  }

  // DELETE
  Future<void> deleteTodo(int id) async {
    await DbHelper.deleteTodo(id);

    loadTodos();
  }

  void showEditDialog(int id, String title) {
    _controller.text = title;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Todo"),
        content: TextField(controller: _controller),
        actions: [
          TextButton(
            onPressed: () {
              updateTodo(id);
              Navigator.pop(context);
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Simple Todo CRUD")),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Enter todo",
                border: OutlineInputBorder(),
              ),
            ),
          ),

          ElevatedButton(
            onPressed: addTodo,
            child: const Text("Add Todo"),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (_, index) {

                final todo = todos[index];

                return ListTile(
                  title: Text(todo['title']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () =>
                            showEditDialog(todo['id'], todo['title']),
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteTodo(todo['id']),
                      ),

                    ],
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}