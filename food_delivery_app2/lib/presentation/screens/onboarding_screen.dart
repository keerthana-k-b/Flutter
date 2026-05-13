import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app2/presentation/screens/login_screen.dart';
import 'package:food_delivery_app2/presentation/screens/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  bool isLoginSelected = true;
  int currentIndex = 0;

   final List<Map<String, dynamic>> onboardingData = [
    {
      "image": "assets/food.png",
      "title": "Delicious Food",
      "desc": "Order your favourite meals easily",
      "colors": [Color(0xFF4CAF84), Color(0xFF6BCB77)],
    },
    {
      "image": "assets/juice.png",
      "title": "Fast Delivery",
      "desc": "Get food at your doorstep quickly",
      "colors": [Color(0xFFFF8A65), Color(0xFFFF7043)],
    },
    {
      "image": "assets/pizza.png",
      "title": "Best Offers",
      "desc": "Enjoy great deals and discounts",
      "colors": [Color(0xFF42A5F5), Color(0xFF1E88E5)],
    },
  ];

  @override
  Widget build(BuildContext context) {

    final data = onboardingData[currentIndex];

    return Scaffold(
       body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
  gradient: LinearGradient(
    colors: data["colors"],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
),

        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child:Column(
  children: [

    SizedBox(height: 40),

    // CAROUSEL (TOP)
    Expanded(
      flex: 3,
      child: CarouselSlider(
        options: CarouselOptions(
          height: double.infinity,
          viewportFraction: 1,
          autoPlay: true,
          onPageChanged: (index, reason) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
        items: onboardingData.map((item) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(item["image"], height: MediaQuery.of(context).size.height * 0.25),
            
                 SizedBox(height: 20),
            
                Text(
                  item["title"],
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            
                 SizedBox(height: 10),
            
                Text(
                  item["desc"],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    ),

    //DOT INDICATOR
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(onboardingData.length, (index) {
        return Container(
          margin:  EdgeInsets.all(4),
          width: currentIndex == index ? 12 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentIndex == index ? Colors.white : Colors.white54,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    ),

     SizedBox(height: 20),

    ///  BUTTONS (BOTTOM)
    Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isFirstTime', false);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              },
              child: _button("Login"),
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
                  MaterialPageRoute(builder: (_) =>  SignupScreen()),
                );
              },
              child: _button("Sign Up"),
            ),
          ),
        ],
      ),
    ),

    const SizedBox(height: 40),
  ],
)
            ),
          ),
        ),
    );
  }
  Widget _button(String text) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 200),
    padding: EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.white),
    ),
    child: Center(
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
}