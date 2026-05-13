import 'package:flutter/material.dart';
import 'package:food_delivery_app2/data/services/auth_service.dart';

class AuthProvider2 extends ChangeNotifier{
  final AuthService _authService = AuthService();

  bool isLoading = false;
  String? error;

  Future<bool> login(String email, String password) async {
    try{
      isLoading = true;
      notifyListeners();

      await _authService.login(email, password);

      isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      error = e.toString();

      isLoading = false;
      notifyListeners();

      return false;
    }
  }

  Future<bool> signup(String email, String password, String phone, String address) async {
    try{
      isLoading = true;
      error = null;
      notifyListeners();

      await _authService.signup(email, password, phone, address);

      isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      error = e.toString();

      isLoading = false;
      notifyListeners();

      return false;
    }
  }


}