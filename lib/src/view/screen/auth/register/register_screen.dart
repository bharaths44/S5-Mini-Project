import 'package:e_commerce_flutter/src/view/screen/auth/login/bg_image.dart';
import 'package:e_commerce_flutter/src/view/screen/auth/register/register_card.dart';
import 'package:e_commerce_flutter/src/view/screen/auth/register/register_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

final RegisterController controller = Get.find<RegisterController>();

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0.0,
        forceMaterialTransparency: true,
        title: const Text('Register'),
      ),
      body: const Stack(
          alignment: Alignment.center, children: [BgImage(), RegisterCard()]),
    );
  }
}
