import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';

class InfoTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
 

  const InfoTextField(
      {super.key,
      required this.controller,
      required this.hint,
      });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: black,
      controller: controller,
      decoration: InputDecoration(
      
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        hintText: hint,
        hintStyle: bodyText3(grey),
    
        fillColor: white,
        filled: true,
      ),
    );
  }
}
