import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatFirebaseService implements ChatService {
  static const String _chatCollection = 'chat';
  FirebaseFirestore store = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>>? snapshots;

  @override
  Stream<List<ChatMessage>> messageStream() {
    snapshots = store.collection(_chatCollection).orderBy('createdAt', descending: true).snapshots();

    return Stream<List<ChatMessage>>.multi((controller) {
      _handleMessages(controller);
    });
  }

  void _handleMessages(MultiStreamController<List<ChatMessage>> controller) {
    snapshots!.listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      final messages = _convertDocsToMessages(snapshot);
      controller.add(messages);
    });
  }

  List<ChatMessage> _convertDocsToMessages(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return ChatMessage.fromMap(doc.data());
    }).toList();
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    DateTime now = DateTime.now();

    final message = ChatMessage(
      id: now.millisecondsSinceEpoch.toString(),
      text: text,
      createdAt: now,
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );

    await store.collection(_chatCollection).add(message.toMap());

    return message;
  }
}
