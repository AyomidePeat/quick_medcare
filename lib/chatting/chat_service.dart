import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quick_medcare/models/message_model.dart';

final chatServiceProvider = Provider<ChatService>((ref) => ChatService());

class ChatService extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final Reference storageReference =
      FirebaseStorage.instance.ref().child('uploads');
   Future<void> sendMessage({
    required String receiverId,
    required String message,
     String? url,
    required String senderName,
    required String senderImage,
  }) async {
    final String currentUserId = firebaseAuth.currentUser!.uid;

    // Generate chat room ID using sender's and receiver's IDs
    String chatRoomId = _generateChatRoomId(currentUserId, receiverId);

    // Message data
    final Timestamp timestamp = Timestamp.now();
    DateTime dateTime = timestamp.toDate();
    final time = DateFormat.Hm().format(dateTime);
    final newMessage = {
      'senderId': currentUserId,
      'senderEmail': firebaseAuth.currentUser!.email,
      'senderName': senderName,
      'senderImage': senderImage,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
      'time': time,
      'url': url,
    };

    // Store message in Firestore
    await firebaseFirestore
        .collection('chat_rooms')
        .doc('$currentUserId$receiverId')
        .collection('messages')
        .add(newMessage);
    await firebaseFirestore
        .collection('chat_rooms')
        .doc('$receiverId$currentUserId')
        .collection('messages')
        .add(newMessage);
  }

  // Generate chat room ID
  String _generateChatRoomId(String senderId, String receiverId) {
    List<String> ids = [senderId, receiverId];
    ids.sort();
    return ids.join("_");
  }

  Stream<QuerySnapshot> getMessages(
    String receiverId,
    String senderId,
  ) {
    List<String> ids = [receiverId, senderId];
    ids.sort();
    return firebaseFirestore
        .collection('chat_rooms')
        .doc(
        '$senderId$receiverId')
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
  Stream<QuerySnapshot> getDoctorMessages(
    String receiverId,
    String senderId,
  ) {
    List<String> ids = [receiverId, senderId];
    ids.sort();
    return firebaseFirestore
        .collection('chat_rooms')
        .doc(
         '$senderId$receiverId')
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

  Future<void> uploadFile(File file, receiverId, senderName, senderImage) async {
    final String fileName = file.path.split('/').last;
    const String mimeType = 'application/octet-stream';
    try {
      final uploadTask = storageReference.child(fileName).putFile(
            file,
            SettableMetadata(contentType: mimeType),
          );

      await uploadTask;
      if (uploadTask.snapshot.state == TaskState.success) {
        String downloadURL =
            await storageReference.child(fileName).getDownloadURL();
        sendMessage(receiverId:  receiverId, message:  fileName, url: downloadURL,senderName:  senderName, senderImage:  senderImage, );
      } else {
        // Handle the file upload error.
      }
    } catch (error) {
      // Handle exceptions here.
      //print('Error uploading file: $error');
    }
  }

  Future<void> addPatientToPatientList(String doctorId, String name,
      String email, String gender, String patientDp, String uid) async {
    try {
      final patientDocRef = FirebaseFirestore.instance
          .collection('${doctorId}patientList')
          .doc('$name $email');
      final patientDocSnapshot = await patientDocRef.get();

      if (!patientDocSnapshot.exists) {
        await patientDocRef.set({
          'patientName': name,
          'patientEmail': email,
          'gender': gender,
          'patientDp': patientDp,
          'uid': uid,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      // Handle errors
    }
  }
}
