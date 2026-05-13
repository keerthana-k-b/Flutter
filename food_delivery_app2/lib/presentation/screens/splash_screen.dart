import 'package:flutter/material.dart';
import 'package:food_delivery_app2/presentation/screens/bottom_nav_screen.dart';
import 'package:food_delivery_app2/presentation/screens/login_screen.dart';
import 'package:food_delivery_app2/presentation/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
  await Future.delayed(Duration(seconds: 3));

  final prefs = await SharedPreferences.getInstance();

  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  if (!mounted) return;

  if (isLoggedIn) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => BottomNavScreen()),
    );
  } else {
    if (isFirstTime) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnboardingScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }
}
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Image.asset("assets/food.png"),
      ),
    );
  }
}

