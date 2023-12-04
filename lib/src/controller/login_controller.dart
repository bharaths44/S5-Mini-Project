import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();

  void login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        // If the email is not verified, navigate to the verify email page
        Get.toNamed('/verifyemail/');
      } else if (user != null && user.emailVerified) {
        // If the email is verified, navigate to the home page
        Get.offAllNamed(
          '/home/',
        );
      } else {
        Get.snackbar(
          'Error:',
          'Login failed. Please try again.',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error :',
        e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }
}
