import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/textstyle.dart';

class MainButton extends StatelessWidget {
  final VoidCallback onpressed;
  final String text;
  final double height;
  final double width;
  const MainButton(
      {super.key,
      required this.onpressed,
      required this.text,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onpressed,
        child: Text(text, style: bodyText2(context)),
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      ),
    );
  }
}
