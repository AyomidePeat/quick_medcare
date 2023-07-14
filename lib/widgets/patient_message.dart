import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';

class PatientMessageContainer extends StatelessWidget {
  final String message;
  final String date;
  const PatientMessageContainer(
      {super.key, required this.message, required this.date});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: blue,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  )),
              child: Text(
                message,
                style: bodyText3(white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  date,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                const SizedBox(width: 5),
                Icon(Icons.done_all, color: blue, size: 15)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
