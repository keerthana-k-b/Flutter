import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {

//variables
final TextEditingController _controller = TextEditingController();
List<String> todos = [];

//init
@override
  void initState(){
    super.initState();
    loadTodos(); //read
  }

  //CRUD FUN
   //READ - LOAD Todos from storage

   Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    todos = prefs.getStringList('todos') ??  [];
    setState(() {
      
    });
   }

   //CREATE ADD NEW TODO

   Future<void> addTodo() async {
    if(_controller.text.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    todos.add(_controller.text);
    await prefs.setStringList('todos', todos);

    _controller.clear();
    setState(() {
      
    });
   }

   //UPDATE EDIT EXISTING TODO

   Future<void> updateTodo(int index) async {
    final prefs = await SharedPreferences.getInstance();
    todos[index] = _controller.text;
    await prefs.setStringList('todos', todos);

    _controller.clear();
    setState(() {
      
    });
   }

   
   //DELETE REMOVE TODO

   Future<void> deleteTodo(int index) async{
    final prefs = await SharedPreferences.getInstance();
    todos.removeAt(index);
    await prefs.setStringList('todos', todos);

    _controller.clear();
    setState(() {
      
    });
   }

   //UI HELPER

   void showEditDialog(int index){
    _controller.text = todos[index];

    showDialog(
      context: context, 
      builder: (_)=> AlertDialog(
        title: Text("Edit Todo"
        ),
        content: TextField(controller: _controller),
        actions: [
          TextButton(
            onPressed:(){
              updateTodo(index);
              Navigator.pop(context);
            },
            child: Text(
              "Update"
            ),
          ),
        ],
      ),
    );
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Todo App"
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),

        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Enter your task",
                  prefixIcon: Icon(Icons.task),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
           ),

           Padding(
             padding:  EdgeInsets.symmetric(horizontal: 12),
             child: SizedBox(
              width: 400,
               child: ElevatedButton(
                onPressed: addTodo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.all(14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))
                ),
                child: Text(
                  "Add Todo",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                  ),
                ),
                ),
             ),
           ),
           SizedBox(height: 20),

            Expanded(
              child:ListView.builder(
                itemCount: todos.length,
                itemBuilder: (_,index){
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                child: ListTile(
                    title: Text(
                      todos[index],
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: ()=>showEditDialog(index), 
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: ()=>deleteTodo(index),
                        ),
                      ],
                    ),
              
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