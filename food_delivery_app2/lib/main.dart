import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app2/core/fcm_service.dart';
import 'package:food_delivery_app2/core/local_notification_service.dart';
import 'package:food_delivery_app2/presentation/provider/auth_provider.dart';
import 'package:food_delivery_app2/presentation/provider/cart_provider.dart';
import 'package:food_delivery_app2/presentation/provider/food_provider.dart';
import 'package:food_delivery_app2/presentation/provider/order_provider.dart';
import 'package:food_delivery_app2/presentation/screens/splash_screen.dart';
import 'package:provider/provider.dart';

final fcmService =FcmService();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await fcmService.init('userId');
  fcmService.listen();

  await LocalNotificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider2()),
        ChangeNotifierProvider(create: (_) => FoodProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
       // ChangeNotifierProvider(create: (_) => TrackingProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        //colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      //),
      home: SplashScreen(),
      ),
    );
  }
}

