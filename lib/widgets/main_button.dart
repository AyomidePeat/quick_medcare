import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/colors.dart';


class MainButton extends StatelessWidget {
  final VoidCallback onpressed;
  final Widget child;
  final double height;
  final double width;
  const MainButton(
      {super.key,
      required this.onpressed,
      required this.child,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        child: child),
    
    );
  }
}
