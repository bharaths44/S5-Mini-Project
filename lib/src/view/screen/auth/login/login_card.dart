// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_flutter/src/view/screen/auth/login/login_controller.dart';
import 'package:e_commerce_flutter/src/view/widget/inputfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginCard extends StatelessWidget {
  LoginCard({super.key});

  final LoginController controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    const String logo = 'assets/images/logo_icon.svg';
    final Widget logosvg = SvgPicture.asset(logo);
    return SafeArea(
      child: Container(
        height: height * 0.5,
        width: width * 0.85,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 10,
              blurRadius: 5,
              offset: const Offset(0, 0), // changes x,y position of shadow
            ),
          ],
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(45, 10, 45, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: logosvg,
            ),
            InputField(
              name: 'Email',
              controller: controller.email,
              labelText: 'Enter Email',
              icon: const Icon(Icons.email_outlined),
            ),
            InputField(
              name: 'Password',
              controller: controller.password,
              obscureText: true,
              labelText: 'Enter password',
              icon: const Icon(Icons.lock_outline_sharp),
            ),
            ElevatedButton(
                onPressed: (() {
                  controller.login();
                }),
                child: const Text("Login")),
            TextButton(
                onPressed: () {
                  Get.toNamed(
                    '/forgot_password/',
                  );
                },
                child: const Text("Forgot Password?")),
            Row(
              children: [
                const Text("Not registered yet?"),
                TextButton(
                  onPressed: () {
                    Get.toNamed(
                      '/register/',
                    );
                  },
                  child: const Text("Register here"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
