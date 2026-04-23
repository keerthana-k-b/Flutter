import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future signUp(
    String email,
    String password,
    String phone,
    String address,
  ) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
        );

        String uid = userCredential.user!.uid;

        String? token = await FirebaseMessaging.instance.getToken();

        await firestore.collection('user').doc(uid).set({
          'uid':uid,
          'email':email,
          'phone': phone,
          'address': address,
          'fcmToken': token,
          'createdAt': Timestamp.now(),
        });

        print("User registered + data stored");
    }catch(e) {
      print("Error: $e");
    }
  }

  //LOGIN
  Future login(String email, String password) async {
    await auth.signInWithEmailAndPassword(
      email: email, 
      password: password,
      );
  }

  //LOGOUT
  Future logout() async{
    await auth.signOut();
  }


