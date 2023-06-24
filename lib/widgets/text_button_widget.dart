import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/colors.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomTextButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, color: blue),));
  }
}
