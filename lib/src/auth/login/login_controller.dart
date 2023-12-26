import 'package:e_commerce_flutter/src/customerview/controller/product_controller.dart';
import 'package:e_commerce_flutter/src/customerview/view/screen/home_screen/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final ProductController controller = Get.find<ProductController>();
  final DashBoardController dashboardController =
      Get.find<DashBoardController>();
  final email = TextEditingController();
  final password = TextEditingController();

  void clearControllers() {
    email.clear();
    password.clear();
  }

  void login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      clearControllers();
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        // If the email is not verified, navigate to the verify email page
        Get.toNamed('/verifyemail/');
      } else if (user != null && user.emailVerified) {
        // If the email is verified, navigate to the home page
        executeOnInitLogic();
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

  void logout() async {
    await FirebaseAuth.instance.signOut();
    clearControllers();
    dashboardController.initTabIndex();
    Get.offAllNamed('/login/');
  }

  void forgotPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.trim());
      Get.snackbar(
        'Success',
        'Password reset email sent. Please check your email.',
        backgroundColor: Colors.green,
      );
      clearControllers();
      Get.offAllNamed('/login/');
    } catch (e) {
      Get.snackbar(
        'Error:',
        e.toString(),
        backgroundColor: Colors.red,
      );
    }
  }

  void executeOnInitLogic() {
    controller.fetchProducts();
    controller.fetchUsername();
  }
}
