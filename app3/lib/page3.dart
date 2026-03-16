import 'package:flutter/material.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text("Container....",
        style: TextStyle(color: Color.fromARGB(255, 61, 59, 54),
        ),
        ),
      ),
      //   body: Container(
      //   height: 300,
      //   width: double.infinity,
      //   // alignment: Alignment.center,
      //   // margin: const EdgeInsets.all(30),
      //   decoration: BoxDecoration(
      //     color: Colors.green,
      //     borderRadius: BorderRadius.circular(15),
      //     border.all(color: Colors.black,
      //     width: 3),
      //   ),
      //   child: Text
      //   "Hello!  I am inside a container!",
      //   style:
      //   TextStyle(
      //     fontSize: 20,
      //     color: Colors.white
      //   ),
      // ),

      
    );
  }
}