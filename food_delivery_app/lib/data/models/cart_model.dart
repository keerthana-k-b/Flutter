import 'food_model.dart';

class CartModel {
  final FoodModel food;
  int quantity;

  CartModel({
    required this.food,
    this.quantity = 1,
  });

  double get totalPrice => food.price * quantity;
}