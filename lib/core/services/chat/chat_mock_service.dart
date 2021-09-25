import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'dart:async';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _messages = [
    ChatMessage(
      id: '1',
      text: 'Good morning',
      createdAt: DateTime.now(),
      userId: '2',
      userName: 'Tech Lead',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'Good morning. Do we need to develop today?',
      createdAt: DateTime.now(),
      userId: '1',
      userName: 'Developer',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '3',
      text: 'Yes, we do, always',
      createdAt: DateTime.now(),
      userId: '2',
      userName: 'Tech Lead',
      userImageUrl: 'assets/images/avatar.png',
    ),
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _messagesStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    _controller?.add(_messages);
  });

  @override
  Stream<List<ChatMessage>> messageStream() {
    return _messagesStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    DateTime now = DateTime.now();
    final newMessage = ChatMessage(
      id: now.microsecondsSinceEpoch.toString(),
      text: text,
      createdAt: now,
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );
    _messages.add(newMessage);
    _controller?.add(_messages.reversed.toList());
    return newMessage;
  }
}
