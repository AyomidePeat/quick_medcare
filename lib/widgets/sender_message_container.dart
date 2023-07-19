import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/colors.dart';

class SenderMessageContainer extends StatelessWidget {
  final String message;
  final String date;
  const SenderMessageContainer(
      {super.key, required this.message, required this.date});

  @override
  Widget build(BuildContext context) {
    return  Align(alignment: Alignment.centerLeft,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container( margin:  const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: grey,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Text(message),
            ),
            Text(
              date,
              style:  TextStyle(fontStyle: FontStyle.italic, fontFamily: 'Poppins-Regular', fontSize: 9, color: black),
            ),
          ],
        ),
    
    );
  }
}
