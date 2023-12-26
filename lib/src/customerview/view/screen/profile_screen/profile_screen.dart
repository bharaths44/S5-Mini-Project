// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_flutter/src/customerview/controller/firebase_auth.dart';
import 'package:e_commerce_flutter/src/auth/login/login_controller.dart';
import 'package:e_commerce_flutter/src/customerview/view/screen/profile_screen/orders.dart';
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
      appBar: AppBar(
        backgroundColor: const Color(0xFFf16b26),
        title: const Text("Profile Screen",
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.w300,
            )),
      ),
      body: FutureBuilder<String>(
        future: getUserName(user),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            String username = snapshot.data ?? "Guest";
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 100, // adjust as needed
                        backgroundImage:
                            AssetImage('assets/images/profile_pic.png'),
                      ),
                      const SizedBox(height: 20), // adjust as needed
                      Text(
                        "Hello $username",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30, // adjust as needed
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2, // adjust as needed
                    children: [
                      InkWell(
                        onTap: loginController.logout,
                        child: GridTile(
                          footer: IconButton(
                            icon: const Icon(Icons.logout),
                            onPressed: loginController.logout,
                          ),
                          child: const Center(
                            child: Text(
                              "Logout",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => OrderScreen());
                        },
                        child: GridTile(
                          footer: IconButton(
                            icon: const Icon(Icons.shopping_cart),
                            onPressed: () {
                              Get.to(() => OrderScreen());
                            },
                          ),
                          child: const Center(
                            child: Text(
                              "Orders",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
