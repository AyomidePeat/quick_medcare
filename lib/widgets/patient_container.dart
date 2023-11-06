import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';

class PatientContainer extends StatelessWidget {
  final String name;
  final String email;
  
  //final String gender;

  const PatientContainer({
    super.key,
    required this.name,
    required this.email, 
   
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:8.0),
          child: Text(
            name,
            style: headLine4(black),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.only(left:8.0),
          child: Text(
            email,
            style: bodyText4(black),
          ),
        ),
        Divider(color:  Colors.blue[100],)
      ],
    );
  }
}
