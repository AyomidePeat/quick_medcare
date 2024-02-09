import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';

class AppointmentWidget extends StatelessWidget {
  final String doctor;
  final String time;
  final String date;
  const AppointmentWidget({super.key, required this.doctor, required this.time, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: headLine2(blue),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width:MediaQuery.of(context).size.width-60,
              child: Text('You have an appointment with Dr. $doctor by $date at $time',overflow: TextOverflow.clip,
                  style: headLine3(black)),
            ),
           
          ],
        )
      ],
    );
  }
}
