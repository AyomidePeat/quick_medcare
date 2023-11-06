import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';

class DoctorContainer extends StatelessWidget {
  final String image;
  final String name;
  final String role;
  const DoctorContainer(
      {super.key, required this.image, required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return doctorDetails();
  }

  Widget doctorDetails() {
    return Column(
      children: [
        SizedBox(height:30),
        Row(
          children: [
            CircleAvatar(
              minRadius: 20,
              backgroundImage: NetworkImage(image),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              children: [
                Text(
                  name,
                  style: headLine3(black),
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.center,
                ),
                Text(
                  role,
                  style: bodyText4(black),
                ),
              ],
            )
          ],
        ),
        Divider(color: Colors.blue[100])
      ],
    );
  }
}
