import 'package:flutter/material.dart';
import 'package:myapp19/provider/album_provider.dart';
import 'package:provider/provider.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  @override
  void initState(){
    super.initState();

    Provider.of<AlbumProvider>(context,
    listen: false).getTodos();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Todos"),
      centerTitle: true,
      backgroundColor: Colors.blue,
     ),

     body: Container(
      padding: EdgeInsets.all(10),
      child: Provider.of<AlbumProvider>(context).isLoading
          ?Center(child: CircularProgressIndicator(),)
            :ListView.builder(
              itemCount: Provider.of<AlbumProvider>(context).todos.length,
              itemBuilder: (context,index){
                final todo = Provider.of<AlbumProvider>(context).todos[index];
                return Card(
                  elevation: 6,
                  
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),

                    leading: CircleAvatar(
                      radius: 22,
                      backgroundColor: todo.completed ? Colors.green : Colors.orange,
                      child: Icon(
                        todo.completed ? Icons.check : Icons.padding,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),

                       // Text(todo.id.toString()),
                        //Text(todo.title),
                        //Text(todo.completed.toString()),

                         Row(
                           children: [
                              Text(
                                  "Status : ",
                               style: TextStyle(fontWeight: FontWeight.w500),
                               ),

                              Text(
                                todo.completed ? "Completed" : "Pending",
                                style: TextStyle(
                                color: todo.completed ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                             ),
                           ),
                         ],
                       ),
                     
                      ],
                    ),
                    trailing: Icon(
                      todo.completed ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: todo.completed ? Colors.green : Colors.grey,
                    ),
                  ),
                );
            })
    ),

    );
  }
}