import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/colors.dart';

class DepartmentContainer extends StatelessWidget {
  final String text;
  final screen;
  const DepartmentContainer({super.key, required this.text, required this.screen});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screen));
      },
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 0.4),
        ),
        child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
            )),
      ),
    );
  }
}
