import 'dart:convert';

class ChatUser {
  final String id;
  final String name;
  final String email;
  final String imageUrl;

  const ChatUser({required this.id, required this.name, required this.email, required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
    };
  }

  factory ChatUser.fromMap(Map<String, dynamic> map) {
    return ChatUser(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      imageUrl: map['imageUrl'],
    );
  }
}
