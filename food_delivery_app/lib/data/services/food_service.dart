import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/data/models/food_model.dart';

class FoodService {

  Stream<List<FoodModel>> getFoodsByCategory(String category) {
   
   //ALL
   if (category.isEmpty) {
    return FirebaseFirestore.instance
        .collection('foods')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return FoodModel.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }
  
  //FILTERED CATEGORY
   return FirebaseFirestore.instance
      .collection('foods')
      .where('category', isEqualTo: category)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      return FoodModel.fromFirestore(doc.data(), doc.id);
    }).toList();
  });
 }

}