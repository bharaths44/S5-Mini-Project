import 'package:e_commerce_flutter/src/view/screen/auth/login/bg_image.dart';
import 'package:e_commerce_flutter/src/view/screen/auth/login/login_card.dart';
import 'package:e_commerce_flutter/src/view/screen/auth/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[200],
      body: Stack(
        alignment: Alignment.center,
        children: [
          const BgImage(),
          LoginCard(),
        ],
      ),
    );
  }
}
