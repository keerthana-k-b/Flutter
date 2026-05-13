import 'food_model.dart';

class CartModel {
  final FoodModel food;
  int quantity;
  bool isSelected;

  CartModel({
    required this.food,
    this.quantity = 1,
    this.isSelected = false,
  });

  double get totalPrice => food.price * quantity;
}