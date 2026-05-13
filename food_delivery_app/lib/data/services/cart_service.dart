import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/data/models/cart_model.dart';

class CartService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> saveCart(List<CartModel> items) async {

  final cartData = items.map((item) => {
    "title": item.food.title,
    "price": item.food.price,
    "image": item.food.image,
    "quantity": item.quantity,
  }).toList();

  final docRef = await _db.collection('orders').add({
    "items": cartData,
    "total": items.fold<double>(
      0,
      (sum, e) => sum + e.totalPrice,
    ),
    "timestamp": FieldValue.serverTimestamp(),
    "status": "preparing"
  });

  return docRef.id; //  RETURN ORDER ID
}
  
}