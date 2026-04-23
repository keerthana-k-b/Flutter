import 'package:employeemanagement/screens/attendance_screen.dart';
import 'package:employeemanagement/screens/availability_screen.dart';
import 'package:employeemanagement/screens/home_screen.dart';
import 'package:employeemanagement/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),
    const AvailabilityScreen(),
    const AttendanceScreen(),
    const ProfileScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],

      /// MODERN FLOATING BOTTOM NAV
      bottomNavigationBar: Container(
        margin:  EdgeInsets.all(16),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavItem(Icons.home, "Home", 0),
            buildNavItem(Icons.add, "Availability", 1),
            buildNavItem(Icons.calendar_month, "Attendance", 2),
            buildNavItem(Icons.person, "Profile", 3),
          ],
        ),
      ),
    );
  }

  /// NAVIGATION ITEM
  Widget buildNavItem(IconData icon, String label, int index) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: AnimatedContainer(
        duration:  Duration(milliseconds: 250),
        padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 28,
                color: isSelected ? Colors.blue : Colors.grey.shade400),
             SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}