import 'package:app3/views.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page",
        style: TextStyle(
         fontSize: 30,
         color: const Color.fromARGB(255, 39, 58, 73),
         fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true,
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  size: 75,
                  color: Colors.grey,

                ),
                SizedBox(height: 25),
               
               Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                ),
               ),

               SizedBox(height: 30),

               Container(
                height: 40,
                width: 400,
                color: Colors.indigoAccent,
                 child: TextField(
                  decoration: InputDecoration(
                    labelText: "Email", 
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(), 
                  ),
                 ),
               ),

               SizedBox(height: 30),

               Container(
                height: 40,
                width: 400,
                color: Colors.indigoAccent,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  
                 ),
               ),

               SizedBox(height: 30),

               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Container(
                    height: 30,
                    width: 200,
                    child: FloatingActionButton(onPressed:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Views()));
                      print("Login Button Pressed");
                    },
                    child: Text("Login",
                    style: TextStyle(fontSize: 18),
                    ),
                    ),
                   ),

               Container(
                height: 30,
                width: 200,
                child: FloatingActionButton(onPressed:(){
                  print("Logout Button Pressed");
                },
                child: Text("Logout",
                style: TextStyle(fontSize: 18),
                ),
                ),
               ),
               ],
              ),
               SizedBox(height: 15),

               Text(
                "Don't have an account? Register",
                style: TextStyle(color: Colors.black),
               ),

              ],
            ),
            ),
        ),
      ) ,
    );
  }
}