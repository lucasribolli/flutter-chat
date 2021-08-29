import 'package:chat/logic/notification/firebase_notification_helper.dart';
import 'package:chat/widgets/messages.dart';
import 'package:chat/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
      
    final fbm = FirebaseMessaging.instance;
    await fbm.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onBackgroundMessage(backgroundNotificationHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('Notification opened the app');
    });
  }

  @override
  Widget build(BuildContext context) {
    const String LOGOUT_VALUE = 'logout';

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  value: LOGOUT_VALUE,
                  child: Container(
                      child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      SizedBox(width: 2.w),
                      Text('Sair'),
                    ],
                  )),
                ),
              ],
              onChanged: (String? item) async {
                if (item == LOGOUT_VALUE) {
                  await FirebaseAuth.instance.signOut();
                }
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
