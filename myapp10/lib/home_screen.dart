import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home"
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                "Welcome to Home",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
               
              FloatingActionButton(onPressed: (){},
              child: Icon(Icons.add),
              ),

            ],

          ),
        ),
      ),

    );
  }
}