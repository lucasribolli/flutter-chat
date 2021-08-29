import 'package:chat/models/message_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  late TextEditingController _textEditingController;
  late String _enterededMessage;
  late bool _sendEnabled;

  Future<void> _sendMessage() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      MessageData messageData = MessageData(
        text: _enterededMessage,
        createdAt: Timestamp.now(),
        userId: user.uid,
        userName: userData.get('name'),
        userImage: userData.get('imageUrl'),
      );

      await FirebaseFirestore.instance.collection('chat').add(messageData.toMap());
    }
  }

  @override
  void initState() {
    _enterededMessage = '';
    _sendEnabled = false;
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                top: 1.h,
                bottom: 1.5.h,
                right: 1.w,
                left: 2.w,
              ),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'Enviar mensagem',
                ),
                onChanged: (value) {
                  setState(() {
                    _sendEnabled = value.trim().isNotEmpty;
                  });
                  _enterededMessage = value;
                },
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              if (_enterededMessage.trim().isEmpty) {
                return;
              }
              await _sendMessage();
              _enterededMessage = '';
              setState(() {
                _sendEnabled = false;
              });
              _textEditingController.clear();
            },
            icon: Icon(
              Icons.send,
            ),
            color: _sendEnabled ? Theme.of(context).iconTheme.color : Theme.of(context).disabledColor,
          )
        ],
      ),
    );
  }
}
