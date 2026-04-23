import 'package:firebase_provider/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final email = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();

  void signup() async {
    await context.read<AuthProvider1>().signUp(
      email.text,
      password.text,
      phone.text,
      address.text,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Signup Successful")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 20),

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

            Row(
              children: [
                Text(
                  "Phone",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),

            TextFormField(
              controller: phone,
              decoration: InputDecoration(
                labelText: "Phone",
                hintText: "Enter your phone number",
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
                  "Address",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),

            TextFormField(
              controller: address,
              decoration: InputDecoration(
                labelText: "Address",
                hintText: "Enter your address",
                filled:  true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(),
                ), 
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: signup, 
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8),
              )
            ),
            child: Text("Signup"),
            ),
          ],
        ),
      ),
    );
  }
}