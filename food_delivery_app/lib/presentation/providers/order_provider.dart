import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/models/order_model.dart';
import 'package:food_delivery_app/data/services/order_service.dart';

class OrderProvider extends ChangeNotifier {
  final OrderService _service = OrderService();

  List<OrderModel> orders = [];

  void listenOrders() {
    _service.getOrders().listen((data) {
      orders = data;
      notifyListeners();
    });
  }
}