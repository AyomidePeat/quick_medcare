import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/textstyle.dart';

class ChatTextField extends StatelessWidget {
  final TextEditingController controller;
  const ChatTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(textInputAction: TextInputAction.done,
        controller: controller,
        cursorColor: black,
        autocorrect: true,
         maxLines: null,
         enableSuggestions: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: 'Send a message',
          hintStyle: bodyText3(black),
          fillColor: grey,
          filled: true,
        ),
      ),
    );
  }
}
