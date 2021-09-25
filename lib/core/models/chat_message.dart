import 'dart:convert';

class ChatMessage {
  final String id;
  final String text;
  final DateTime createdAt;

  final String userId;
  final String userName;
  final String userImageUrl;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.userId,
    required this.userName,
    required this.userImageUrl,
  });

  Map<String, dynamic> toMap() {
    print('toMap = $id');
    return {
      'id': id,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
      'userId': userId,
      'userName': userName,
      'userImageUrl': userImageUrl,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    print('fromMap = $map');
    return ChatMessage(
      id: map['id'],
      text: map['text'],
      createdAt: DateTime.parse(map['createdAt']),
      userId: map['userId'],
      userName: map['userName'],
      userImageUrl: map['userImageUrl'],
    );
  }

  @override
  String toString() {
    return 'ChatMessage(id: $id, text: $text, createdAt: $createdAt, userId: $userId, userName: $userName, userImageUrl: $userImageUrl)';
  }
}
