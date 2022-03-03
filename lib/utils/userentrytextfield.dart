import 'package:flutter/material.dart';

class UserEntryTextField extends StatelessWidget {
  final TextEditingController controller;

  final String labelText;

  final bool obscureText;
  const UserEntryTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      style: const TextStyle(
          fontStyle: FontStyle.normal, fontSize: 20, color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        errorStyle: const TextStyle(fontSize: 15),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
