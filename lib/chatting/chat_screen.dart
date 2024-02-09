import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_medcare/chatting/chat_service.dart';
import 'package:quick_medcare/models/patient_model.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';
import 'package:quick_medcare/widgets/chat_textfield.dart';
import 'package:quick_medcare/widgets/my_message_container.dart';
import 'package:quick_medcare/widgets/sender_message_container.dart';
import 'package:file_picker/file_picker.dart';

class ChatScreen extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserId;
  final String receiverName;
  final String senderName;
  final String senderEmail;
  final String senderUid;
  final String receiverImage;
  final String senderImage;
  final String userType;

  final String gender;

  const ChatScreen(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserId,
      required this.receiverName,
      required this.senderName,
      required this.senderEmail,
      required this.receiverImage,
      required this.senderImage,
      required this.userType,
      required this.gender,
      required this.senderUid});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final ScrollController _scrollController = ScrollController();

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom, // Specify the file types you want to allow
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'gif',
        'mp4',
        'mp3',
        'wav',
        'pdf',
        'aac',
        'xlsx',
        'doc',
        'docx',
        'mkv'
      ],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      await chatService.uploadFile(file, widget.receiverUserId, widget.senderName, widget.senderImage);
    } else {}
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(
          widget.receiverUserId, messageController.text.trim(), null, widget.senderName, widget.senderImage);
      messageController.clear();
    }

    if (widget.userType == 'patient') {
      chatService.addPatientToPatientList(
          widget.receiverUserId,
          widget.senderName,
          widget.senderEmail,
          widget.gender,
          widget.senderImage,
          widget.senderUid);
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  PatientDetailsModel patientN = PatientDetailsModel(
      firstName: 'firstName',
      lastName: 'lastName',
      gender: 'gender',
      email: 'email',
      uid: 'uid',
      role: 'role');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: blue,
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios, color: white)),
            centerTitle: true,
            title: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.receiverImage),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.userType == 'patient'
                      ? 'Dr. ${widget.receiverName}'
                      : '${widget.receiverName}',
                  style: headLine2(white),
                ),
                const SizedBox(
                  width: 30,
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.video_call_rounded, color: Colors.white))
              ],
            )),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [_buildMessageList(), _buildMessageInput()],
          ),
        ));
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        ChatTextField(controller: messageController),
        IconButton(onPressed: sendMessage, icon: const Icon(Icons.send)),
        IconButton(
            onPressed: () {
              pickFile();
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: blue, duration: const Duration(seconds: 5),
                        content: const Text('Sending...',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16))));
            },
            icon: const Icon(Icons.attach_file_outlined)),
      ],
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    if (data.containsKey('senderId') &&
        data.containsKey('message') &&
        data.containsKey('time')) {

      return (data['senderId'] == firebaseAuth.currentUser!.uid)
          ? MyMessageContainer(
              message: data['message'],
              date: data['time'],
              url: data['url'],
            )
          : SenderMessageContainer(
              senderName: widget.receiverName,
              message: data['message'],
              date: data['time'],
              url: data['url']);
    } else {
      return Container();
    }
  }

  Widget _buildMessageList() {
  return StreamBuilder<QuerySnapshot>(
    stream: chatService.getMessages(
      widget.receiverUserId, firebaseAuth.currentUser!.uid),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Text('Loading...');
      }
      if (!snapshot.hasData) {
        return const Text('No users available');
      }
 WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        // Scroll to the bottom once new messages are loaded
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
      return Flexible(
        child: ListView(
          controller: _scrollController,  // Attach the ScrollController here
          children: snapshot.data!.docs
            .map((document) => _buildMessageItem(document))
            .toList(),
        ),
      );
    },
  );
}
}
