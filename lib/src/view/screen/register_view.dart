import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _displayName;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _displayName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _displayName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register View"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          TextField(
            controller: _displayName,
            decoration: const InputDecoration(hintText: 'Enter display name'),
          ),
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Enter email'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: "Enter password"),
          ),
          TextButton(
            onPressed: () async {
              final displayName = _displayName.text;
              final email = _email.text;
              final password = _password.text;

              try {
                final userCredential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );

                // Update the user's display name
                await userCredential.user?.updateDisplayName(displayName);

                // Navigate to the next screen or perform other actions
              } on FirebaseAuthException catch (e) {
                String errorMessage = 'An error occurred.';

                if (e.code == 'weak-password') {
                  errorMessage = 'The password provided is too weak.';
                } else if (e.code == 'email-already-in-use') {
                  errorMessage = 'The account already exists for that email.';
                } else if (e.code == 'invalid-email') {
                  errorMessage = 'Invalid email address.';
                }

                // Show a snackbar with the error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text("Register"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/login/',
                (route) => false,
              );
            },
            child: const Text("Back to Login Screen"),
          )
        ],
      ),
    );
  }
}
