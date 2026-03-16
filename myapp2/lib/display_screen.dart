import 'package:flutter/material.dart';

class DisplayScreen extends StatefulWidget {
  final String text1;
  final String text2;
  const DisplayScreen({super.key,required this.text1,required this.text2});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text(
              widget.text1
            ),
          
          
          ),

          SizedBox(height: 20),

          Text(
            widget.text2
          )
        ],
      ),
    );
  }
}