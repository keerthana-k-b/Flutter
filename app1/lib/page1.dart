import 'package:flutter/material.dart';

class Mypage extends StatefulWidget {
  const Mypage({super.key});

  @override
  State<Mypage> createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keerthana "),
      ),
      body: Column(
        children: [Center(child: Row(
          children: [
            Text("Hello flutter"),
          ],
        )),Text("Keerthana")],
      )
    );
  }
}