import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app2/core/local_notification_service.dart';
import 'package:food_delivery_app2/data/models/order_model.dart';

class OrderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///  CREATE ORDER
  Future<String> createOrder({
    required List items,
    required double total,
  }) async {

    final doc = await _db.collection('orders').add({
      "status": "preparing",

      "items": items,
      "total": total,

      "timestamp": FieldValue.serverTimestamp(),
    });

     final orderId = doc.id;
     
     // Trigger notification immediately after success
     await LocalNotificationService.showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: "Order Created",
      body: "Your order is being prepared",
     );

     // Wait 30 seconds
     Future.delayed(Duration(seconds: 30), () async {
        await doc.update({
        "status": "confirmed",
     });

     //  notify again when confirmed
    await LocalNotificationService.showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: "Order Confirmed",
      body: "Your order is confirmed",
    );
  });

    return orderId;
  }


  Stream<List<OrderModel>> getOrders() {
  return _db
      .collection('orders')
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) =>
              OrderModel.fromMap(doc.id, doc.data()))
          .toList());
}
}

