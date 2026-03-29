import 'package:flutter/material.dart';
import 'package:myapp11/login_screen.dart';
import 'package:myapp11/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();

    bool isLogin = prefs.getBool('isLogin') ?? false ;

    await Future.delayed(Duration(seconds: 3));

    if(isLogin){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileScreen()),);
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()),);
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
      //backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/butterfly.png"),
      ),
    );
  }
}