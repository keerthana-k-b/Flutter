import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class CrashTestScreen extends StatefulWidget {
  const CrashTestScreen({super.key});

  @override
  State<CrashTestScreen> createState() => _CrashTestScreenState();
}

class _CrashTestScreenState extends State<CrashTestScreen> {

  Widget buildButton({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 55),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        icon: Icon(icon, color: Colors.white),
        label: Text(title, style: TextStyle(color: Colors.white)),
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crashlytics Dashboard"),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            //  Force Crash
            buildButton(
              title: "Force App Crash",
              icon: Icons.warning,
              color: Colors.red,
              onPressed: () {
                throw Exception("Test Crash ");
              },
            ),

            //  Non-fatal error
            buildButton(
              title: "Log Non-Fatal Error",
              icon: Icons.error_outline,
              color: Colors.orange,
              onPressed: () {
                try {
                  int x = 10 ~/ 0;
                } catch (e, stack) {
                  FirebaseCrashlytics.instance
                      .recordError(e, stack, fatal: false);
                }
              },
            ),

            //  Add log
            buildButton(
              title: "Add Debug Log",
              icon: Icons.note,
              color: Colors.blue,
              onPressed: () {
                FirebaseCrashlytics.instance
                    .log("User clicked debug button");
              },
            ),

            //  Custom key
            buildButton(
              title: "Set Custom Key",
              icon: Icons.key,
              color: Colors.green,
              onPressed: () {
                FirebaseCrashlytics.instance
                    .setCustomKey("screen", "CrashTestScreen");
              },
            ),

          ],
        ),
      ),
    );
  }
}