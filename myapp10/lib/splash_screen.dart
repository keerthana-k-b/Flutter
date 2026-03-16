import 'package:flutter/material.dart';
import 'package:myapp10/home_screen.dart';
import 'package:myapp10/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> checkLogin() async {
  final prefs = await SharedPreferences.getInstance();
  bool isLogin = prefs.getBool('isLogin') ?? false;

  await Future.delayed(Duration(seconds: 2)); // splash delay

  if (isLogin) {
    Navigator.pushReplacement(
      context,
      
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
  @override

  void initState(){
    super.initState();
    checkLogin();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 90),

              Container(
                height: 200,
                width: 200,
              child: Image.asset("assets/girl.png",
              fit: BoxFit.cover,
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}