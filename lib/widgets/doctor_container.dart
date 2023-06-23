import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/colors.dart';

class DoctorContainer extends StatelessWidget {
  final String image;
  final String name;
  final String role;
  const DoctorContainer(
      {super.key, required this.image, required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        //width: size.width * 0.4,
        //height: size.width * 0.7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.transparent,
            // border: Border.all(
            //   color: black,
            //   width: 0.4,
            // )
            ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 200,
              width: size.width * 0.4,
              decoration: BoxDecoration(border: Border.all(),
                borderRadius: BorderRadius.circular(10),
               
              ),
              child: Image.asset(image, fit:BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                name,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:10),
              child: Text(role),
            )
          ],
        ));
  }
}
