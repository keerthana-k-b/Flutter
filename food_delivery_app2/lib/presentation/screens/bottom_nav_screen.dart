import 'package:flutter/material.dart';
import 'package:food_delivery_app2/presentation/screens/home_screen.dart';
import 'package:food_delivery_app2/presentation/screens/order_history_screen.dart';
import 'package:food_delivery_app2/presentation/screens/profile_screen.dart';
import 'package:food_delivery_app2/presentation/screens/search_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {

  int currentIndex = 0;

  final List<Widget> pages = [
    HomeScreen(),
    SearchScreen(),
    OrderHistoryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: pages[currentIndex],

      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            _navItem(Icons.home, 0),
            _navItem(Icons.search, 1),
            _navItem(Icons.history, 2),
            _navItem(Icons.person_outlined, 3),

          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, int index){
    bool isActive = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Icon(
        icon,
        color: isActive ? Colors.black : Colors.grey,
        size: 26,
      ),
    );
  }
  
}