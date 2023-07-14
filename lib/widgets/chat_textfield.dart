import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/textstyle.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(width:size.width*0.6,
    height:40,
      child: TextField(
        cursorColor: black,
        decoration: InputDecoration(contentPadding: EdgeInsets.all(10),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: 'Write a reply...',
          hintStyle: bodyText3(black),
          fillColor: grey,
          filled: true,
        ),
      ),
    );
  }
}
