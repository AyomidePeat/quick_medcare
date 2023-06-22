import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/textstyle.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Icon icon;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hint,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        hintText: hint,
        hintStyle: bodyText2(context),
        prefixIcon: icon,
      ),
    );
  }
}
