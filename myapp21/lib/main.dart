import 'package:flutter/material.dart';
import 'package:myapp21/providers/weather_provider.dart';
import 'package:myapp21/screens/weather_home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: MaterialApp(
        title: 'Weather – Kochi',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.black,
          fontFamily: 'SF Pro Display', // Falls back to system default on non-iOS
          colorScheme: ColorScheme.dark(
            primary: const Color(0xFF4FC3F7),
            secondary: const Color(0xFF81D4FA),
          ),
        ),
        home: const WeatherHomeScreen(),
      ),
    );
  }
}

