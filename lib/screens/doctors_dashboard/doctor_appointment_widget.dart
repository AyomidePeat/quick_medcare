import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';

class DoctorAppointmentWidget extends StatelessWidget {
  final String patient;
  final String time;
  final String date;
   DoctorAppointmentWidget({super.key, required this.patient, required this.time, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '•',
          style: headLine2(blue),
        ),
        Column(
          children: [
            Text('You have an appointment with $patient',
                style: headLine3(black)),
            Text('by $date at $time', style: bodyText3(black)),
          ],
        )
      ],
    );
  }
}
