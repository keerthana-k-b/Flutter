import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/data/models/order_model.dart';

class OrderService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///  CREATE ORDER
  Future<String> createOrder({
    required double userLat,
    required double userLng,

    required List items,
    required double total,
  }) async {

    final doc = await _db.collection('orders').add({
      "userLat": userLat,
      "userLng": userLng,
      "riderLat": userLat, // initially same
      "riderLng": userLng,
      "status": "preparing",

      "items": items,
      "total": total,

      "timestamp": FieldValue.serverTimestamp(),
    });

    return doc.id;
  }

  ///  STREAM ORDER (REAL-TIME)
  Stream<OrderModel> streamOrder(String orderId) {
    return _db.collection('orders').doc(orderId).snapshots().map(
      (doc) => OrderModel.fromMap(doc.id, doc.data()!),
    );
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