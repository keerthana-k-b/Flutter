import 'package:firebase_demo/auth_service.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  bool loading = false;

  void handleSignup() async {
    setState(() => loading = true);

    try{
      await signUp(
        emailController.text.trim(), 
        passwordController.text.trim(), 
        phoneController.text.trim(), 
        addressController.text.trim(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup Successful")),
        );

        Navigator.pop(context);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signup Failed")),
      );
    }

    setState(() => loading = false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      title: Text("SignUp"),
     ),

    body: Container(
     decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.deepPurple, Colors.purpleAccent],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  child: Center(
    child: SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text("Create Account ",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

              SizedBox(height: 20),

              buildField(emailController, "Email", Icons.email),
              buildField(passwordController, "Password", Icons.lock),
              buildField(phoneController, "Phone", Icons.phone),
              buildField(addressController, "Address", Icons.home),

              SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: handleSignup,
                child: loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Sign Up"),
              )
            ],
          ),
        ),
       ),
      ),
     ),
    ),
   );
  }

  Widget buildField(controller, text, icon) {
  return Padding(
    padding: EdgeInsets.only(bottom: 15),
    child: TextField(
      controller: controller,
      obscureText: text == "Password",
      decoration: InputDecoration(
        labelText: text,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}

}