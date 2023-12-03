// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_flutter/src/view/widget/inputfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login View"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InputField(
            name: 'Email',
            controller: _email,
            labelText: 'Enter Email',
          ),
          const Divider(
            color: Colors.transparent,
            height: 25,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          InputField(
            name: 'Password',
            controller: _password,
            obscureText: true,
            labelText: 'Enter password',
          ),
          ElevatedButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email, password: password);

                User? user = FirebaseAuth.instance.currentUser;
                if (user != null && !user.emailVerified) {
                  // If the email is not verified, navigate to the verify email page
                  Navigator.of(context).pushNamed('/verifyemail/');
                } else if (user != null && user.emailVerified) {
                  // If the email is verified, navigate to the home page
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home/',
                    (route) => false,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Login failed. Please try again.',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } catch (e) {
                // Catch all exceptions and display them in a Snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Error: ${e.toString()}',
                    ),
                  ),
                );
              }
            },
            child: const Text("Login"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
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
