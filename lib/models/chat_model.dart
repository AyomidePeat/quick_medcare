class ChatModel {
  final String name;
  final String profilePic;
  final String uid;
  final DateTime timeSent;
  final bool isOnline;
  final String content;
  ChatModel({
    required this.name,
    required this.profilePic,
    required this.uid,
    required this.timeSent,
    required this.content,
    required this.isOnline,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profilePic': profilePic,
      'contactId': uid,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'lastMessage': content,
      'isOnline': isOnline,
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> map) {
    return ChatModel(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      uid: map['contactId'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      content: map['lastMessage'] ?? '',
      isOnline: map['isOnline'] ?? false,
    );
  }
}
