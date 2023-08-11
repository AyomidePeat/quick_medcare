import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';

class PatientContainer extends StatelessWidget {
  final String name;
  final String email;
  final String image;
  final String gender;

  const PatientContainer({
    super.key,
    required this.name,
    required this.email, required this.image, required this.gender,
    //  required this.age, required this.image
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: double.infinity,
      padding: const EdgeInsets.all(10),
      height: 100,
      decoration:
          BoxDecoration(color: grey, borderRadius: BorderRadius.circular(10)),
      child: Row(children: [
        CircleAvatar(
          backgroundImage: NetworkImage(image),
          radius: 50,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: headLine4(black),
            ),
            Text(
              gender,
              style: bodyText4(black),
            ),
            Text(
              email,
              style: bodyText4(black),
            )
          ],
        )
      ]),
    );
  }
}
