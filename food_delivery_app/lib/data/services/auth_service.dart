import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/core/fcm_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FcmService _fcmservice = FcmService();

  Future<User?> login(String email, String password) async {
    final res = await _auth.signInWithEmailAndPassword(
      email: email, 
      password: password,
    );

    String? token = await _fcmservice.getToken();

    await _firestore.collection('user').doc(res.user!.uid).update({
      '_fcmToken': token,
    });

    print("FCM TOKEN (Login) : $token");

    return res.user;
  }

  Future<User?> signup(String email, String password, String phone, String address) async {
    final res = await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password,
    );

    String? token = await _fcmservice.getToken();
    print("FCM TOKEN (signup) : $token");

    await _firestore.collection('user').doc(res.user!.uid).set({
      'email': email,
      'phone': phone,
      'address': address,
      '_fcmToken': token,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return res.user;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}