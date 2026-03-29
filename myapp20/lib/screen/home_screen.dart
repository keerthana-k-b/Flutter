import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp20/screen/weather_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/earth.jpg"),
            fit: BoxFit.cover
            ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            Text(
              "Welcome To",
               style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
                letterSpacing: 1.5,
              ),
            ),
            Text(
              "ATMOSHERE",
              style: GoogleFonts.poppins(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 28, 141, 233),
                letterSpacing: 2,
              ),
            ),
            Text(
              "Your Weather App",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
                
              ),
            ),

            SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white,width: 1.5),
                color: Colors.white.withOpacity(0.1),
              ),
              child: TextButton(onPressed: (){
                Navigator.push(context,
                 MaterialPageRoute(builder: (context)=>WeatherScreen()),);
              }, 
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
              ),
              child: Text(
                "Get Started",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              )),
            )

          ],
        ),
      ),
    );
  }
}