// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_flutter/src/view/widget/inputfield.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
               InputField(
            name: 'Email',
            controller: _emailController,
            labelText: 'Enter Email',
          ),
               InputField(
            name: 'Password',
            controller: _passwordController,
            labelText: 'Enter Password',
          ),
              InputField(
                name: 'Name',
                controller: _nameController,
                labelText: 'Enter Name',
              ),
              InputField(
                controller: _addressController,
                name: 'Address',
                labelText: 'Enter Address',
              ),
              InputField(
                labelText: 'Enter Phone Number',
                controller: _phoneNumberController,
                name: 'Phone Number',
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await signUp(
                        _emailController.text,
                        _passwordController.text,
                        _nameController.text,
                        _addressController.text,
                        _phoneNumberController.text,
                        false, // Set isAdmin to false for regular users
                        [], // Empty favorites list initially
                        [], // Empty cart initially
                      );
                      // Show a SnackBar with a success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Successfully registered')),
                      );
                      // Navigate to the login page
                      Navigator.of(context).pushNamed('/verifyemail/');
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${e.toString()}')));
                    }
                  }
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signUp(
    String email,
    String password,
    String name,
    String address,
    String phoneNumber,
    bool isAdmin,
    List favorites,
    List cart,
  ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': name,
          'address': address,
          'phoneNumber': phoneNumber,
          'isAdmin': isAdmin,
          'favorites': favorites,
          'cart': cart,
        });
      }
    } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }
}
