import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          "Container...",
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: Container(
        height: 200,
        width: double.infinity,
        color: Colors.greenAccent,
        child: Text(
          "Hello! I am inside a container!",
          style: TextStyle(fontSize: 20,
          color: Colors.white),
        ),
      ),
    );
  }
}