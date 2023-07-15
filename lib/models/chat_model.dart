class ChatModel {
  final String name;
  final String profilePic;
  final String contactId;
  final DateTime timeSent;
  final String content;
  ChatModel({
    required this.name,
    required this.profilePic,
    required this.contactId,
    required this.timeSent,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'lastMessage': content,
    };
  }

  
  factory ChatModel.fromJson(Map<String, dynamic> map) {
    return ChatModel(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      contactId: map['contactId'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      content: map['lastMessage'] ?? '',
    );
  }
}
