// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_flutter/src/customerview/controller/firebase_auth.dart';
import 'package:e_commerce_flutter/src/auth/login/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final LoginController loginController = Get.put(LoginController());

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: FutureBuilder<String>(
        future: getUserName(user),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            String username = snapshot.data ?? "Guest";
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Image.asset('assets/images/profile_pic.png')),
                Text(
                  "Hello $username",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset('assets/images/github.png', width: 60),
                    SizedBox(width: 10),
                    Text(
                      "Profile Screen",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                ElevatedButton(
                  child: const Text('Logout'),
                  onPressed: () async {
                    loginController.logout();
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
