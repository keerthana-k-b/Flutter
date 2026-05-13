import 'package:flutter/material.dart';
import 'package:food_delivery_app2/presentation/provider/auth_provider.dart';
import 'package:food_delivery_app2/presentation/screens/bottom_nav_screen.dart';
import 'package:food_delivery_app2/presentation/screens/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider2>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              "Welcome Back",
              style: GoogleFonts.poppins(
              fontSize: 26,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 30),

            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Enter your email",
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(10),
                // ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.blue, width: 1.5),
                ),
              ),
            ),
            
            SizedBox(height: 20),

            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Enter your Password",
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(10),
                // ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.blue, width: 1.5),
                ),
              ),
            ),

            SizedBox(height: 25),

            ElevatedButton(
             onPressed: () async {
              bool success = await auth.login(
              emailController.text,
             passwordController.text,
             );

            if (success) {

      
              final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', true);
                await prefs.setBool('isFirstTime', false);

     
                 Navigator.pushAndRemoveUntil(
                 context,
                   MaterialPageRoute(builder: (_) => BottomNavScreen()),
                  (route) => false,
                );

               } else {
                ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text(auth.error ?? "Login Failed")),
              );
             }
            }, 
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: Size(double.infinity, 50),
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
             child: auth.isLoading
                  ? CircularProgressIndicator()
                  :Text("Login"),
            ),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => SignupScreen()),
                );
              },
              child: Text("Create Account"),
            )
          ],
        ),
      ),
    );
  }
}