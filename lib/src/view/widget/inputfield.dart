import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final String name;

  const InputField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        labelText: labelText,
        // enabledBorder: OutlineInputBorder(
        //     borderSide: const BorderSide(width: 4, color: Colors.amberAccent),
        //     borderRadius: BorderRadius.circular(25)),
        // focusedBorder: OutlineInputBorder(
        //     borderSide: const BorderSide(width: 4, color: Colors.amberAccent),
        //     borderRadius: BorderRadius.circular(25))
      ),
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$name not entered';
        }
        return null;
      },
    );
  }
}
