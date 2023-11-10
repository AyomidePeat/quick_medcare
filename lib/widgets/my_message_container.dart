import 'package:flutter/material.dart';
import 'package:quick_medcare/chatting/file_preview.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';


class MyMessageContainer extends StatelessWidget {
  final String message;
  final String date;
  final String? url;
  final String user = 'You';

  const MyMessageContainer({
    super.key,
    required this.message,
    required this.date,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          url != null
              ? GestureDetector(
                  onTap: () 
                  => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FilePreview(user: user,
                                message: message,
                                url: url,
                              ))),
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: blue,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          )),
                      child: Text(
                        message,
                        style: headLine3(white),
                      )),
                )
              : Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: blue,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Text(
                    message,
                    style: bodyText3(white),
                  ),
                ),
          Text(
            date,
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontFamily: 'Poppins-Regular',
                fontSize: 9,
                color: black),
          ),
        ],
      ),
    );
  }


}
