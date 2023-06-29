import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double height;
  final double width;
  final Border? border;
  const CustomContainer(
      {super.key,
      required this.child,
      required this.color,
      required this.height,
      required this.width, this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(5), border: border),
      child: child,
    );
  }
}
