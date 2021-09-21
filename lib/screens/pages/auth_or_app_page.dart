import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/screens/pages/auth_page.dart';
import 'package:chat/screens/pages/chat_page.dart';
import 'package:chat/screens/pages/loading_page.dart';
import 'package:flutter/material.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<ChatUser?>(
      stream: AuthService().userChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        } else {
          return snapshot.hasData ? const ChatPage() : const AuthPage();
        }
      },
    ));
  }
}
