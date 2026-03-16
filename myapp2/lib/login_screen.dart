import 'package:flutter/material.dart';
import 'package:myapp2/display_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  String email = '';
  String pswd = '';

  void display(){
    setState(() {
      email = _emailcontroller.text;
      pswd = _passwordcontroller.text;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Row(
                  children: [
                    Text("Email"),
                  ],
                ),

                SizedBox(height: 20),

                TextFormField(
                  controller: _emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )
                  ),
                ),

                SizedBox(height: 20),

                Row(
                  children: [
                    Text("Password"),
                  ],
                ),

                SizedBox(height: 20),
              
              TextFormField(
                controller: _passwordcontroller,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_open),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )
                ),
              ),

              SizedBox(height: 20),

              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                ),
                onPressed: 
                //display,
                (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayScreen(
                    text1:_emailcontroller.text,
                    text2:_passwordcontroller.text
                  )));
                },
                child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              ),

               SizedBox(height: 20),

              Text(email),
              SizedBox(height: 20),

              Text(pswd),

              ],
            ),
            ),
        ),
        
      ),
    );
  }
}