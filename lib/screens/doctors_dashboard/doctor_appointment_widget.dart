import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';

class DoctorAppointmentWidget extends StatelessWidget {
  final String patient;
  final String time;
  final String date;
  final String appointmentNote;
  DoctorAppointmentWidget(
      {super.key,
      required this.patient,
      required this.time,
      required this.date, required this.appointmentNote});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: headLine2(blue),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('You have an appointment with $patient',
                style: headLine3(black)),
            Text('on $date at $time', style: bodyText3(black)),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Appointment Note: ', style: TextStyle(fontSize: 14,decoration: TextDecoration.underline, color: black),),
                Text(appointmentNote,style: bodyText3(black)),
              ],
            ),
          ],
        )
      ],
    );
  }
}
