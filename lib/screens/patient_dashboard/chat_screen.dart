import 'package:flutter/material.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/widgets/chat_list.dart';
import 'package:quick_medcare/widgets/chat_textfield.dart';

import '../../utils/textstyle.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Row(
          children: [
             CircleAvatar(backgroundImage: AssetImage('images/heritage.jpg', )),
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dr. Heritage', style: headLine3(black)),
                Text('Online',style: bodyText2(context),)
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: grey),
              child: const Text('Today'),
            ),
            const SizedBox(height: 15),
            const ChatList(),
            const Divider(thickness: 5,),
            const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChatTextField(), 
                Icon(Icons.emoji_emotions_outlined),
                Icon(Icons.mic_none_rounded),
                Icon(Icons.camera_alt_outlined)
              ],
            )
          ],
        ),
      ),
    );
  }
}
