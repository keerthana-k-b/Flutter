import 'package:firebase_provider/presentation/providers/auth_provider.dart'; // ✅ MUST
import 'package:firebase_provider/presentation/screens/home_screen.dart';
import 'package:firebase_provider/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final email = TextEditingController();
  final password = TextEditingController();

  void login() async {
    try {
      await context.read<AuthProvider1>().login(
        email.text.trim(),
        password.text.trim(),
      );
      
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login Successful")),
        );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
              children: [
                Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),

            TextFormField(
              controller: email,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Enter your email",
                filled:  true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(),
                ), 
              ),
            ),

            SizedBox(height: 20),

            Row(
              children: [
                Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),

            TextFormField(
              controller: password,
              decoration: InputDecoration(
                labelText: "Password",
                filled:  true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(),
                ), 
              ),
            ),

            SizedBox(height: 20),

          ElevatedButton(onPressed: login,
           style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8),
              )
            ),
           child: Text("Login"),
           ),

           SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SignupScreen()));
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8),
              )
            ),
            child: Text("Signup"),
          )
        ],
      ),
    );
  }
}