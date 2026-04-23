import 'package:firebase_messaging/firebase_messaging.dart';

class FcmService {
  final FirebaseMessaging messaging;

  FcmService(this.messaging);

  Future<void>  init() async {
    await messaging.requestPermission();

    String? token = await messaging.getToken();
    print("FCM: $token");

    FirebaseMessaging.onMessage.listen((event) {
      print("Notification: ${event.notification?.title}");
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      print("NEW TOKEN: $newToken");
    });
    
  }
}