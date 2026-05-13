import 'package:flutter/material.dart';
import 'package:food_delivery_app/presentation/screens/login_screen.dart';
import 'package:food_delivery_app/presentation/screens/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  bool isLoginSelected = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
       body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4CAF84),
              Color(0xFF6BCB77),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            ),
        ),

        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),

                Center(
                  child: Image.asset("assets/food.png",
                  height: 250,
                  ),
                ),

                Spacer(),

                Text(
                  "Our food delivery app brings your favourite dishes to you",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 15),

                Text(
                  "With our user-friendly food delivery app,\n"
                  "you will enjoy the ultimate convenience.",
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          
                          final prefs = await SharedPreferences.getInstance();
                          
                          await prefs.setBool('isFirstTime', false); 

                           Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) =>  LoginScreen()),
                            );
                        },

                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: !isLoginSelected ? Colors.black : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                      SizedBox(width: 15),

                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final prefs = await SharedPreferences.getInstance();
                            
                            await prefs.setBool('isFirstTime', false); 
                            
                            Navigator.pushReplacement(
                             context,
                             MaterialPageRoute(builder: (_) => const SignupScreen()),
                             );
                           },

                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: !isLoginSelected ? Colors.black : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white),
                            ),
                            child: Center(
                              child: Text(
                                "Sign Up",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ), 
                       ),
                     ],
                    ),

                    SizedBox(height: 40),

                  ],
                )
            ),
          ),
        ),
    );
  }
}