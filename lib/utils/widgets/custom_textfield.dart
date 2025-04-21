import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  final icon;
  final ktype;
  CustomTextFiled({
    super.key,
    required this.hint,
    required this.controller,
    required this.icon,
    required this.ktype,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: ktype,
      decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none),
          fillColor: Colors.deepPurpleAccent.withOpacity(0.1),
          filled: true,
          prefixIcon: Icon(icon)),
    );
  }
}
