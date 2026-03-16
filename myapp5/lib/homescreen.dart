import 'package:flutter/material.dart';
import 'package:myapp5/relax_screen.dart';
import 'package:myapp5/sleep_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

             Text(
              "Powerful\nBoost",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),

             SizedBox(height: 40),

            Image.asset(
              "assets/pdt.jpg",
              height: 200,
            ),
            
          
            SizedBox(height: 40),

             Text(
              "Helping humans become happier & healthier!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 40),

            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/RelaxScreen');
              },
              child:  Text("Next"),
            )
          ],
        ),
      ),
    );
  }
}