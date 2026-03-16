import 'package:flutter/material.dart';
import 'package:myapp11/profile_screen.dart';
import 'package:myapp11/signup_screen.dart';
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

  String emailid = prefs.getString('email') ?? '';
  String pwd = prefs.getString('pswd') ?? '';

  if(emailid == _emailidController.text && pwd == _passwordController.text){
  //bool isLogin = true;

  await prefs.setBool('isLogin', true);
  
  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()),);
  }else{
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Email or Password"))); 
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "LOGIN",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [

              SizedBox(height: 30),

              Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Email"
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
                      keyboardType: TextInputType.emailAddress,
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
                      obscureText: true,
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
                    //  (){
                    //   Navigator.push(
                    //     context,
                    //      MaterialPageRoute(builder: (context)=>ProfileScreen()),);
                    // },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
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

                     TextButton(onPressed:(){
                      Navigator.push(context,
                       MaterialPageRoute(builder: (context)=> SignupScreen()
                       ),
                       );
                     }, 
                    child: 
                     Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 18,
                      ),
                     ),
                     ),
                   ],
                 ),
            ],
          ),
        ),
      ),
    );
  }
}