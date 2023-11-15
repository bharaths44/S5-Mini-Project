// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    // Get the display name or use a default if not set
    String username = user?.displayName ?? "Guest";

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Image.asset('assets/images/profile_pic.png')),
          Text(
            "Hello $username",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login/',
                (route) => false,
              );
            },
          )
        ],
      ),
    );
  }
}
