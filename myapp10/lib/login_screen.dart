import 'package:flutter/material.dart';
import 'package:myapp10/home_screen.dart';
import 'package:myapp10/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _emailidController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> data() async {
    final prefs = await SharedPreferences.getInstance();
    //await prefs.setString('emailid', _emailidController.text);
    //await prefs.setString('password', _passwordController.text);
    String emailid = prefs.getString('email')!;
    String password = prefs.getString('pwd')!;
    if(emailid == _emailidController.text && password == _passwordController.text){
      prefs.setBool('isLogin', true);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()),);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Email or Password")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(8.0),
          child: Column(
            children: [

              SizedBox(height: 30),

              Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Password"
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _emailidController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_month),
                        hintText: "Email",
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

              Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Password"
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_month),
                        hintText: "****",
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                   Container(
                    width: 250,
                    height: 30,
                    child: ElevatedButton(onPressed: data,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(12),
                      ),
                    ), 
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                   ),
                 ),

                 SizedBox(height: 20),

                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18,
                      ),
                     ),

                     TextButton(onPressed: (){
                      Navigator.push(context,
                       MaterialPageRoute(builder: (context)=> SignupScreen()
                       ),
                       );
                     }, child: 
                     Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 18,
                      ),
                     ),
                     ),
                   ],
                 )

            ],
          ),
          ),
      ),
    );
  }
}