import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_provider/data/services/auth_service.dart';
import 'package:firebase_provider/data/services/task_service.dart';
import 'package:firebase_provider/presentation/providers/task_provider.dart';
import 'package:firebase_provider/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_provider/presentation/providers/auth_provider.dart';

import 'firebase_options.dart'; 

 void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authService = AuthService();
  final taskService = TaskService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider1(authService)),
        ChangeNotifierProvider(create: (_) => TaskProvider(taskService)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}