import 'package:flutter/material.dart';
import 'package:quick_medcare/widgets/doctor_message_container.dart';
import 'package:quick_medcare/widgets/patient_message.dart';

import '../utils/chat.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          if (messages[index]['isPatient'] == true) {
            return PatientMessageContainer(
              message: messages[index]['text'].toString(),
              date: messages[index]['time'].toString(),
            );
          }
          return DoctorMessageContainer(
            message: messages[index]['text'].toString(),
            date: messages[index]['time'].toString(),
          );
        },
      ),
    );
  }
}
