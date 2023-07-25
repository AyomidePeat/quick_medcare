import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quick_medcare/models/message_model.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  sendMessage(String receiverId, String message) async {
    final String currentUserId = firebaseAuth.currentUser!.uid;
    final String currentUserEmail = firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    DateTime dateTime = timestamp.toDate();
    final time = DateFormat.Hm().format(dateTime);
    final newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp,
        time: time);

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future<String> _uploadImageToStorage(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = storage.ref().child('images/$fileName.jpg');
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> sendImageMessage(String receiverId, File imageFile) async {
        final String currentUserId = firebaseAuth.currentUser!.uid;

    String imageUrl = await _uploadImageToStorage(imageFile);
   final String currentUserEmail = firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    DateTime dateTime = timestamp.toDate();
    final time = DateFormat.Hm().format(dateTime); List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");
    final newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: imageUrl,
        timestamp: timestamp,
        time: time);
        await firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }
}
