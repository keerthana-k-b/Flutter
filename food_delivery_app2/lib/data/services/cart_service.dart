import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app2/data/models/cart_model.dart';
import 'package:food_delivery_app2/data/models/food_model.dart';

class CartService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveCart(List<CartModel> items) async {

  final cartData = items.map((item) => {
    "title": item.food.title,
    "price": item.food.price,
    "image": item.food.image,
    "quantity": item.quantity,
    "isSelected": item.isSelected,
  }).toList();

  //final docRef = 
  await _db.collection('cart').doc("userId").set({
    "items": cartData,
    "total": items.fold<double>(
      0,
      (sum, e) => sum + e.totalPrice,
    ),
    "timestamp": FieldValue.serverTimestamp(),
   // "status": "preparing"
  });

 // return docRef.id; //  RETURN ORDER ID
}

Future<List<CartModel>> loadCart() async {
  final doc = await _db.collection('cart').doc("userId").get();

  if (!doc.exists) return [];

  final data = doc.data();
  final items = data?["items"] ?? [];

  return items.map<CartModel>((item) {
    return CartModel(
      food: FoodModel(
        id: item["title"], 
        title: item["title"],
        price: item["price"],
        image: item["image"], 
        category: '', 
        description: '',
      ),
      quantity: item["quantity"],
      isSelected: item["isSelected"] ?? false,
    );
  }).toList();
}
  
}