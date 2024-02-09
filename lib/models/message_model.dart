import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String senderName;
  final String senderImage;
  final String receiverId;
  final String message;
  final String time;
  final Timestamp timestamp;
  final String? url;

  Message(
      {required this.senderId,
      required this.senderEmail,
      required this.senderImage,
      required this.receiverId,
      required this.message,
      required this.timestamp,
      required this.time,
      required this.senderName,
      this.url});

  Map<String, dynamic> toMap() {
    return {
      'senderImage': senderImage,
      'senderName': senderName,
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
      'time': time,
      'url': url
    };
  }
}
