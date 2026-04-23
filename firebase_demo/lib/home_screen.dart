import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/auth_service.dart';
import 'package:firebase_demo/crash_test_screen.dart';
import 'package:firebase_demo/firestore_service.dart';
import 'package:firebase_demo/login_screen.dart';
import 'package:firebase_demo/task_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void createNewList() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await createList("My List", uid);
  }

  

  @override
  Widget build(BuildContext context) {

    String uid = FirebaseAuth.instance.currentUser!.uid;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Lists"),
  actions: [
  IconButton(
    icon: Icon(Icons.bug_report),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CrashTestScreen()),
      );
    },
  ),

  IconButton(
    icon: Icon(Icons.logout),
    onPressed: () async {
      await logout();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
        (route) => false,
      );
    },
  ),
],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewList,
        child: Icon(Icons.add),
        ),

       body: StreamBuilder(
  stream: FirebaseFirestore.instance
      .collection('lists')
      .where('members', arrayContains: uid)
      .snapshots(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        var doc = snapshot.data!.docs[index];

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Icon(Icons.list, color: Colors.white),
            ),
            title: Text(doc['title'],
                style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TaskScreen(listId: doc.id),
                ),
              );
            },
          ),
        );
      },
    );
  },
),
    );
  }
}