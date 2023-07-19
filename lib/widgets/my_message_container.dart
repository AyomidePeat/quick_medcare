import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';

class MyMessageContainer extends StatelessWidget {
  final String message;
  final String date;
  const MyMessageContainer(
      {super.key, required this.message, required this.date});

  @override
  Widget build(BuildContext context) {
    return  Align(alignment: Alignment.centerRight,
        child: Column(crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
            //   width:300,
            // height:200,
              padding: const EdgeInsets.all(10),
              margin:  const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: blue,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Text(message, style: bodyText3(white),),
            ),
            Text(
              date,
              style:  TextStyle(fontStyle: FontStyle.italic,fontFamily: 'Poppins-Regular', fontSize: 9, color: black ),
            ),
          ],
        ),
    
    );
  }
}
