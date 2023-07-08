import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Icon icon;
  final bool obscureText;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hint,
       required this.obscureText,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: black,obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
      
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        hintText: hint,
        hintStyle: bodyText2(context),
        prefixIcon: icon,
        fillColor: white,
        filled: true,
      ),
    );
  }
}
