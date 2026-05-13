import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/models/cart_model.dart';
import 'package:food_delivery_app/data/models/food_model.dart';

class CartProvider extends ChangeNotifier {

  final List<CartModel> _items = [];

  List<CartModel> get items => _items;

  /// ADD TO CART
  void addToCart(FoodModel food) {
    final index = _items.indexWhere((item) => item.food.id == food.id);

    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartModel(food: food));
    }

    notifyListeners();
  }

  /// INCREASE
  void increaseQty(int index) {
    _items[index].quantity++;
    notifyListeners();
  }

  /// DECREASE
  void decreaseQty(int index) {
    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  /// TOTAL PRICE
  double get totalAmount {
    return _items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  /// CLEAR CART
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}