import 'package:cloud_firestore/cloud_firestore.dart';

class MessageData {
  String text;
  Timestamp createdAt;

  MessageData({
    required this.text,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'createdAt': createdAt,
    };
  }

  factory MessageData.fromMap(Map<String, dynamic> map) {
    return MessageData(
      text: map['text'],
      createdAt: map['createdAt'],
    );
  }
}
