import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_medcare/chatting/chat_screen.dart';
import 'package:quick_medcare/chatting/chat_service.dart';
import 'package:quick_medcare/chatting/doctor_chat_screen.dart';
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
            "Users",
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
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'patient')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          final users = snapshot.data!.docs;

          if (users.isNotEmpty) {
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return buildUserListItem(users[index]);
              },
            );
          }
        }
        return Center(child: Text('No chat yet!', style: headLine2(blue)));
      },
    );
  }

  Widget buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    return ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                    backgroundImage: data.containsKey('imageURL')
                        ? NetworkImage(data['imageURL'])
                        : NetworkImage(
                            'https://img.freepik.com/premium-vector/anonymous-user-circle-icon-vector-illustration-flat-style-with-long-shadow_520826-1931.jpg')),
                SizedBox(width: 5),
                Text('${data['firstName']} ${data['lastName']}'),
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
                  builder: ((context) => DoctorChatScreen(
                     
                      receiverUserEmail: data['email'],
                      receiverUserId: data['uid'],
                      receiverName: '${data['firstName']} ${data['lastName']}',
                      senderName: widget.senderName,
                      senderEmail: widget.senderEmail,
                      receiverImage: data.containsKey('imageURL')
                          ? data['imageURL']
                          : 'https://img.freepik.com/premium-vector/anonymous-user-circle-icon-vector-illustration-flat-style-with-long-shadow_520826-1931.jpg',
                      senderImage: widget.senderImage,
                      userType: widget.userType,
                      gender: '',
                      senderUid: widget.doctorId))));
        });
  }
}
