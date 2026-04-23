import 'package:employeemanagement/screens/bottom_navigation_screen.dart';
import 'package:employeemanagement/screens/login_screen.dart';
import 'package:employeemanagement/service/sharedpreferences/storage_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override

  void initState(){
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    String? token = await StorageService.getToken();


    await Future.delayed(Duration(seconds: 3)); // splash delay

  if (token != null && token.isNotEmpty) {
    Navigator.pushReplacement(
      context,
      
      MaterialPageRoute(builder: (context) => BottomNavigationScreen()),
    );
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            Positioned.fill(child:
            Image.asset("assets/bg.png",
            fit: BoxFit.cover,
             ),
            ),
            Center(
              child: Text(
                "Employee Scheduler",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}