import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';

class DepartmentContainer extends StatelessWidget {
  final String text;
  final screen;
  final Color color;
  final String icon;
  const DepartmentContainer(
      {super.key,
      required this.color,
      required this.text,
      required this.screen,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screen));
      },
      child: Container(
        height: 140,
        width: size.width * 0.43,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: Colors.grey, width: 0.4
          // ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 35,
                child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Image.asset(icon))),
            const SizedBox(height: 15),
            Text(
              text,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  'Explore',
                  style: bodyText5(blue),
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: blue,
                  size: 15,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
