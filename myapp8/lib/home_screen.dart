import 'package:flutter/material.dart';
import 'package:myapp8/login_screen.dart';
import 'package:myapp8/singup_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/girl.png"),
                  fit: BoxFit.contain,
                  ),
              ),
            ),

            SizedBox(height: 20),
            Text(
              "Welcome",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 30),

            Container(
              width: 300,
              height: 30,
              child: ElevatedButton(onPressed: (){
                Navigator.push(
                  context,
                   MaterialPageRoute(builder: (context)=>SingupScreen()
                   ),
                   );
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
              ),
              child: Text(
                "Let's Start",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
                ),
              ),
              ),
            )
          ],
        ),
      ),
    );
  }
}