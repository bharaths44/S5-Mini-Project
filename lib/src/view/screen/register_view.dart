import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _displayName;
  bool _isLoading = false; // Added loading indicator state

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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(), // Loading indicator
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: _displayName,
                  decoration: InputDecoration(
                    hintText: 'Enter display name',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 4, color: Colors.amberAccent),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 4, color: Colors.amberAccent),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                TextField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter email',
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 4, color: Colors.amberAccent),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 4, color: Colors.amberAccent),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                TextField(
                  controller: _password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: "Enter password",
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 4, color: Colors.amberAccent),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 4, color: Colors.amberAccent),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true; // Show loading indicator
                    });

                    final displayName = _displayName.text;
                    final email = _email.text;
                    final password = _password.text;

                    try {
                      final userCredential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      await userCredential.user?.updateDisplayName(displayName);

                      // Navigate to the verification email route
                      Navigator.of(context)
                          .pushReplacementNamed('/verifyemail/');
                    } on FirebaseAuthException catch (e) {
                      String errorMessage = 'An error occurred.';

                      if (e.code == 'weak-password') {
                        errorMessage = 'The password provided is too weak.';
                      } else if (e.code == 'email-already-in-use') {
                        errorMessage =
                            'The account already exists for that email.';
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
                    } finally {
                      setState(() {
                        _isLoading = false; // Hide loading indicator
                      });
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
