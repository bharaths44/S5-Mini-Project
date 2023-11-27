import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  late final NavigatorState navigator;

  @override
  void initState() {
    super.initState();
    navigator = Navigator.of(context); // Store the Navigator instance
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
        backgroundColor: Colors.amber,
      ),
      body: Column(children: [
        const Text("Please verify your email"),
        TextButton(
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
            if (mounted) { // Check if the widget is still mounted
              navigator.pushNamedAndRemoveUntil('/login/', (route) => false);
            }
          },
          child: const Text("Send email verification"),
        )
      ]),
    );
  }
}
