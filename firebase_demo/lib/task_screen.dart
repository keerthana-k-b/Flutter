import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/firestore_service.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {

  final String listId;

  const TaskScreen({super.key, required this.listId});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    String uid = FirebaseAuth.instance.currentUser!.uid;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Enter tasks",
                border: OutlineInputBorder(),
              ),            
            ),
          ),

          ElevatedButton(
            onPressed: (){
              if(controller.text.isNotEmpty){
             addTask(widget.listId, controller.text, uid);
             controller.clear();
              }
            }, 
            child: Text("Add Task"),
           ),

           Expanded(
            child: StreamBuilder(
              stream: getTasks(widget.listId), 
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No Tasks"));
                }

                return ListView.builder(
  itemCount: snapshot.data!.docs.length,
  itemBuilder: (context, index) {
    var doc = snapshot.data!.docs[index];

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: CheckboxListTile(
        title: Text(
          doc['title'],
          style: TextStyle(
            decoration: doc['completed']
                ? TextDecoration.lineThrough
                : null,
          ),
        ),
        value: doc['completed'],
        onChanged: (value) {
          toggleTask(doc.id, value!);
        },
        secondary: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => deleteTask(doc.id),
        ),
      ),
    );
  },
);
              },
             ),
           )
        ],
      ),
    );
  }
}