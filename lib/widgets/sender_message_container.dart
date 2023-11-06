import 'package:flutter/material.dart';
import 'package:quick_medcare/chatting/file_preview.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';


class SenderMessageContainer extends StatelessWidget {
  final String message;
  final String date;
  final String? url;
  final String senderName;
  const SenderMessageContainer(
      {super.key, required this.message, required this.date, this.url, required this.senderName});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          url != null
              ? GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FilePreview(
                                user: senderName,
                                message: message,
                                url: url,
                              ))),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: grey,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        )),
                    child: Text(
                        message,
                        style: headLine3(black),
                      )
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: grey,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Text(
                    message,
                    style: bodyText3(black),
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
