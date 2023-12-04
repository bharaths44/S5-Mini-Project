// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_flutter/src/controller/login_controller.dart';
import 'package:e_commerce_flutter/src/view/widget/inputfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginCard extends StatelessWidget {
  LoginCard({super.key});

  final LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    const String logo = 'assets/images/logo_icon.svg';
    final Widget logosvg = SvgPicture.asset(logo);
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.85,
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
          const Divider(
            color: Colors.transparent,
            height: 15,
            thickness: 1,
          ),
          InputField(
            name: 'Email',
            controller: controller.email,
            labelText: 'Enter Email',
            icon: const Icon(Icons.email_outlined),
          ),
          const Divider(
            color: Colors.transparent,
            height: 15,
            thickness: 1,
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
                '/register/',
              );
            },
            child: const Text("Register here"),
          )
        ],
      ),
    );
  }
}
