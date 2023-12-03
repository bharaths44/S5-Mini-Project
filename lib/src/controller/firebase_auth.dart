import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> signUp(String email, String password, String name, String address, String phoneNumber, bool isAdmin, List<String> favorites, List<String> cart) async {
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );

  User? user = userCredential.user;

  if (user != null) {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
      'isAdmin': isAdmin,
      'favorites': favorites,
      'cart': cart,
    });
  }
}

Future<String> getUserName(User? user) async {
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return userDoc['name'] ?? "Guest";
    }
    return "Guest";
  }