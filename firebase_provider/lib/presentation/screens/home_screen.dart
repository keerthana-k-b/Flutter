import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_provider/presentation/providers/auth_provider.dart';
import 'package:firebase_provider/presentation/providers/task_provider.dart';
import 'package:firebase_provider/presentation/screens/login_screen.dart';
import 'package:firebase_provider/presentation/screens/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider1>();
    final task = context.read<TaskProvider>();

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(child: Text("User not logged in")),
      );
    }

    String uid = user.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text("Lists"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await auth.logout();

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await task.createList("My List", uid);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("List Created")),
          );
        },
        child: Icon(Icons.add),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: task.getLists(uid), 
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return Center(child: Text("No Lists Found"));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, i) {
              var doc = docs[i];

              return ListTile(
                title: Text(doc['title']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TaskScreen(listId: doc.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}