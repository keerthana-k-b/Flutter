// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// class Fcmservice {
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;

//   Future<void> init() async {
//     await _fcm.requestPermission();

//     String? token = await _fcm.getToken();
//     print("FCM TOKEN: $token");
//   }

//   // Listen for foreground messages
//   void listen() {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print("Message received: ${message.notification?.title}");
//     });
//   }

//   Future<String?> getToken() async {
//     return await _fcm.getToken();
//   }

//   Future<void> saveToken(String userId) async {
//     String? token = await FirebaseMessaging.instance.getToken();

//     await FirebaseFirestore.instance
//            .collection('user')
//            .doc(userId)
//            .update({
//             'fcmToken': token,
//            });
//   }

// }


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'local_notification_service.dart';

class FcmService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  /// INIT
  Future<void> init(String userId) async {
    // Request permission
    await _fcm.requestPermission();

    // Get FCM token
    String? token = await _fcm.getToken();
    print("FCM TOKEN => $token");

    /// Save token to Firestore
    if (token != null) {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(userId)
          .set({"fcmToken": token}, SetOptions(merge: true));
    }
  }

  /// LISTEN
  void listen() {
    /// App in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Message received");

      LocalNotificationService.showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: message.notification?.title ?? "Order Update",
        body: message.notification?.body ?? "",
      );
    });

    /// When user taps notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("Notification clicked");
    });
  }

  Future<String?> getToken() async {
    return await _fcm.getToken();
  }
  
}