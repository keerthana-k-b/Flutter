import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/order_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingProvider extends ChangeNotifier {

  final OrderService _orderService = OrderService();

  LatLng? userLocation;
  LatLng? riderLocation;

  List<LatLng> routePoints = [];

  StreamSubscription? _orderSub;

  
  void startTracking(String orderId) {

    _orderSub = _orderService.streamOrder(orderId).listen((order) {

      userLocation = LatLng(order.userLat, order.userLng);
      riderLocation = LatLng(order.riderLat, order.riderLng);

      _drawRoute();

      notifyListeners();
    });
  }

  
  void _drawRoute() {
    if (userLocation == null || riderLocation == null) return;

    routePoints = [
      riderLocation!,
      LatLng(
        (riderLocation!.latitude + userLocation!.latitude) / 2,
        (riderLocation!.longitude + userLocation!.longitude) / 2,
      ),
      userLocation!,
    ];
  }

  @override
  void dispose() {
    _orderSub?.cancel();
    super.dispose();
  }
}