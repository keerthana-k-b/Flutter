import 'package:flutter/material.dart';
import 'package:myapp17/model/todos_model.dart';
import 'package:myapp17/service/todos_service.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {

  final TodosService _service = TodosService();
  late Future<List<TodosModel>> _todos;
  
  @override
  void initState(){
    super.initState();
    _todos = _service.fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "API Todos"
        ),
        centerTitle: true,
      ),

      body: FutureBuilder<List<TodosModel>>(
        future: _todos, 
        builder: (context,snapshot){

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator()
            );
          }
          
          if(snapshot.hasError){
            return Center(
              child: Text(
                "Error loading data"
              ),
            );
          }

          final todos = snapshot.data!;

          return GridView.builder(
            padding: EdgeInsets.all(10),
            itemCount: todos.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
            ), 
            itemBuilder: (context,index){
                 final todo = todos[index];

                 return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          todo.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(height: 15),

                        Text(
                          todo.userId.toString(),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(height: 15),

                        Text(
                          todo.id.toString(),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(height: 15),

                        Text(
                          todo.completed.toString(),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),


                      ],
                    ),),
                 );
            },
            );
        }),
    );
  }
}