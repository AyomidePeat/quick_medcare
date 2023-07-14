import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';

class IllnessContainer extends StatelessWidget {
  final String icon;
  final String illness;
  final String treatmentMode;
  final String date;
  const IllnessContainer(
      {super.key,
      required this.icon,
      required this.illness,
      required this.treatmentMode,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 248, 243, 243)),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 160, 180, 223)),
              child: SizedBox(
                  height: 35,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      icon,
                    ),
                  )),
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$illness, $treatmentMode',
                  style: headLine3(black),
                ),
                Text(
                  date,
                  style: bodyText3(grey),
                )
              ],
            )
          ],
        ));
  }
}
