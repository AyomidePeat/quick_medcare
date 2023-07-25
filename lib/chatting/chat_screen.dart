import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_medcare/chatting/chat_service.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';
import 'package:quick_medcare/widgets/chat_textfield.dart';
import 'package:quick_medcare/widgets/my_message_container.dart';
import 'package:quick_medcare/widgets/sender_message_container.dart';

import '../utils/upload_image.dart';

class ChatScreen extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserId;
  final String name;
  final String image;
  const ChatScreen(
      {super.key,
      required this.receiverUserEmail,
      required this.name,
      required this.receiverUserId, required this.image});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ChatService chatService = ChatService();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    XFile? _imageFile;
  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(
          widget.receiverUserId, messageController.text);
      messageController.clear();
    }
  }
  ImageUpload imageUpload = ImageUpload();
// Future<void> _pickImage() async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _imageFile = pickedFile;
//     });
//   }
  File convertXFileToFile(XFile xFile) {
    final filePath = xFile.path;
    return File(filePath);
  }

  Future<void> _sendMessageWithImage() async {
    if (_imageFile != null) {
      File image = File(_imageFile!.path); 
      await chatService.sendImageMessage(
        widget.receiverUserId,
        image,
      );
      setState(() {
        _imageFile = null;
      });
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

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
                  backgroundImage: NetworkImage(widget.image),
                ),
                const SizedBox(width: 10,),
                Text(
                  'Dr. ${widget.name}',
                  style: headLine2(white),
                ),
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
         IconButton(onPressed: (){
                                    imageUpload.uploadImage(context, (pickedImg) {
                            setState(() {
                              _imageFile = pickedImg;
                            });
                            final pickedImageFile =
                                convertXFileToFile(pickedImg);
                            chatService
                                .sendImageMessage(  widget.receiverUserId,  pickedImageFile);
                          });

         }, icon: const Icon(Icons.attach_file_outlined)),
      ],
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    if (data.containsKey('senderId') &&
        data.containsKey('message') &&
        data.containsKey('time')) {
      return (data['senderId'] == firebaseAuth.currentUser!.uid)
          ? MyMessageContainer(message: data['message'], date: data['time'])
          : SenderMessageContainer(
              message: data['message'],
              date: data['time'],
            );
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
          return Flexible(
            child: ListView(
              children: snapshot.data!.docs
                  .map((document) => _buildMessageItem(document))
                  .toList(),
            ),
          );
        });
  }
}
