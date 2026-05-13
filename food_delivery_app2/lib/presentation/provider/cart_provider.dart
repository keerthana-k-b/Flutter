import 'package:flutter/material.dart';
import 'package:food_delivery_app2/data/models/cart_model.dart';
import 'package:food_delivery_app2/data/models/food_model.dart';
import 'package:food_delivery_app2/data/services/cart_service.dart';

class CartProvider extends ChangeNotifier {

  final List<CartModel> _items = [];

  List<CartModel> get items => _items;

  // ADD TO CART
  void addToCart(FoodModel food) {
    final index = _items.indexWhere((item) => item.food.id == food.id);

    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartModel(food: food));
    }

    CartService().saveCart(_items);

    notifyListeners();
  }

  // INCREASE
  void increaseQty(int index) {
    _items[index].quantity++;
    notifyListeners();
  }

  // DECREASE
  void decreaseQty(int index) {
    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  // /// TOTAL PRICE
  // double get totalAmount {
  //   return _items.fold(0, (sum, item) => sum + item.totalPrice);
  // }

  /// CLEAR CART
  // void clearCart() {
  //   _items.clear();
  //   notifyListeners();
  // }

  void toggleSelection(int index) {
   _items[index].isSelected = !_items[index].isSelected;
   notifyListeners();
  }

  List<CartModel> get selectedItems {
   return _items.where((item) => item.isSelected).toList();
  }

  double get selectedTotal {
    return selectedItems.fold(
      0,
      (sum, item) => sum + item.totalPrice,
    );
  }

  void removeSelectedItems() {
    _items.removeWhere((item) => item.isSelected);
    notifyListeners();
  }

  Future<void> loadCartFromFirebase() async {
  final service = CartService();
  final data = await service.loadCart();

  _items.clear();
  _items.addAll(data);
    print("Firestore data: $data");
  notifyListeners();
}

}