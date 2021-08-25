import 'package:chat/models/message_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  late TextEditingController _textFieldController;
  late String _enterededMessage;
  late bool _sendEnabled;

  Future<void> _sendMessage() async {
    MessageData messageData = MessageData(
      text: _enterededMessage,
      createdAt: Timestamp.now(),
    );

    await FirebaseFirestore.instance.collection('chat').add(messageData.toMap());
  }

  @override
  void initState() {
    _enterededMessage = '';
    _sendEnabled = false;
    _textFieldController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
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
                controller: _textFieldController,
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
              _textFieldController.clear();
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
