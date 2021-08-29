import 'package:cloud_firestore/cloud_firestore.dart';

class MessageData {
  String text;
  Timestamp createdAt;
  String userId;
  String userName;
  String userImage;

  MessageData({
    required this.text,
    required this.createdAt,
    required this.userId,
    required this.userName,
    required this.userImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'createdAt': createdAt,
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
    };
  }

  factory MessageData.fromMap(Map<String, dynamic> map) {
    return MessageData(
      text: map['text'],
      createdAt: map['createdAt'],
      userId: map['userId'],
      userName: map['userName'],
      userImage: map['userImage'],
    );
  }
}
