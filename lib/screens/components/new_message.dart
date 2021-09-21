import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _message = '';
  final _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;

    if (user != null) {
      await ChatService().save(_message, user);
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 2.w,
            ),
            child: TextField(
              controller: _messageController,
              onChanged: (String message) {
                setState(() {
                  _message = message;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Send message...',
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: _messageController.text.trim().isEmpty ? null : _sendMessage,
          icon: const Icon(Icons.send),
        )
      ],
    );
  }
}
