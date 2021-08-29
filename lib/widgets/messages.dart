import 'package:chat/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _doesMessageBelongsToMe(String userId) {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        return FirebaseAuth.instance.currentUser!.uid == userId;
      }
      return false;
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final List<QueryDocumentSnapshot>? chatDocs = chatSnapshot.data?.docs;

        return ListView.builder(
          reverse: true,
          itemCount: chatDocs?.length,
          itemBuilder: (context, index) {
            return MessageBubble(
              message: chatDocs?[index].get('text'),
              belongsToMe: _doesMessageBelongsToMe(chatDocs?[index].get('userId')),
              userName: chatDocs?[index].get('userName'),
              userImage: chatDocs?[index].get('userImage'),
              key: ValueKey(chatDocs?[index].id),
            );
          },
        );
      },
    );
  }
}
