import 'package:firebase_provider/data/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider1 extends ChangeNotifier {
  final AuthService service;

  AuthProvider1(this.service);

  Future login(String email, String password) async {
    await service.login(email, password);
  }

  Future signUp(String email, String password, String phone, String address) async {
    await service.signUp(email, password, phone, address);
  }

  Future logout() async {
    await service.logout();
  }
}