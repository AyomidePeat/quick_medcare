import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_medcare/chatting/chat_screen.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';

class ChatListScreen extends StatefulWidget {
  final String senderEmail;
  final String userType;
  final String senderImage;

  final String doctorId;

  final String senderName;
  const ChatListScreen(
      {super.key,
      required this.doctorId,
      required this.senderEmail,
      required this.userType,
      required this.senderImage,
      required this.senderName});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final auth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: white,
                size: 20,
              )),
          title: Text(
            "Chats",
            style: headLine2(white),
          ),
          backgroundColor: blue,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: buildUserList(),
        ));
  }

  Widget buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: firebaseFirestore
            .collection('chat_rooms')
            .doc(widget
                .doctorId) // Assuming widget.doctorId is the document ID under chat_room
            .collection('messages')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final doctors = snapshot.data!.docs;
            
            if (doctors.isNotEmpty) {
              return ListView(
                children: doctors
                    .map<Widget>((doc) => buildUserListItem(doc))
                    .toList(),
              );
            }
          }
          return Center(child: Text('No chat yet!', style: headLine2(blue)));
        });
  }

  Widget buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (auth.currentUser!.email != data['senderEmail']) {
      return ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(),
                  SizedBox(width: 5),
                  Text(data['senderName']),
                ],
              ),
              Divider(
                color: grey,
              )
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => ChatScreen(
                        receiverUserEmail: data['senderEmail'],
                        receiverUserId: widget.doctorId,
                        receiverName: data['senderName'],
                        senderName: widget.senderName,
                        senderEmail: widget.senderEmail,
                        receiverImage: data['senderImage'],
                        senderImage: widget.senderImage,
                        userType: widget.userType,
                        gender: '',
                        senderUid: widget.doctorId))));
          });
    } else {
      return Container();
    }
  }
}
