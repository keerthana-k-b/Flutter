import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  size: 80,
                  color: Colors.blue,
                ),
                SizedBox(height: 20),

                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  ),

                  SizedBox(height: 30),

                  TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(), 
                    ),
                  ),

                  SizedBox(height: 20),

                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 30),
                   
                   ElevatedButton(onPressed: (){}, child: Text("Cancel")),

                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(color: const Color.fromARGB(255, 250, 250, 250)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 158, 185, 199)),
                      onPressed: (){
                        print("Login Button Pressed");
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 18 , color: const Color.fromARGB(255, 8, 8, 4)),
                      
                    ),
                  ),
               ),
               
               SizedBox(height: 15),

               Text(
                "Don't have an account? Register",
                style: TextStyle(color: Colors.grey),
               ),
              ],
             ),
          ),
        ),
      ),
    
    );
  }
}