import 'package:cloud_firestore/cloud_firestore.dart';

class MessageData {
  String text;
  Timestamp createdAt;
  String userId;
  String userName;

  MessageData({
    required this.text,
    required this.createdAt,
    required this.userId,
    required this.userName,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'createdAt': createdAt,
      'userId': userId,
      'userName': userName,
    };
  }

  factory MessageData.fromMap(Map<String, dynamic> map) {
    return MessageData(
      text: map['text'],
      createdAt: map['createdAt'],
      userId: map['userId'],
      userName: map['userName'],
    );
  }
}
