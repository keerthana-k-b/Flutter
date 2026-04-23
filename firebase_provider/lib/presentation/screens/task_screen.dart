import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_provider/presentation/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatefulWidget {
  final String listId;

  const TaskScreen({required this.listId});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TaskProvider>();
    String uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: Text("Tasks")),
      body: Column(
        children: [
          TextField(controller: controller),

          ElevatedButton(
            onPressed: () {
              provider.addTask(widget.listId, controller.text, uid);
              controller.clear();
            },
            child: Text("Add Task"),
          ),

          Expanded(
            child: StreamBuilder(
              stream: provider.getTasks(widget.listId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (_, i) {
                    var doc = snapshot.data!.docs[i];

                    return CheckboxListTile(
                      title: Text(doc['title']),
                      value: doc['completed'],
                      onChanged: (val) {
                        provider.toggleTask(doc.id, val!);
                      },
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