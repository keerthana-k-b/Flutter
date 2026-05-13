import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  /// INIT
  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(
      android: android,
    );

    await _notifications.initialize(
      initSettings, // ✅ IMPORTANT (this is "settings")
    );
  }

  /// SHOW NOTIFICATION
  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'order_channel',
      'Order Updates',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(
      android: androidDetails,
    );

    await _notifications.show(
      id,       // ✅ REQUIRED
      title,
      body,
      details,  // ✅ REQUIRED
    );
  }
}