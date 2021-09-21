import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/notification/chat_notification_service.dart';
import 'package:chat/screens/components/messages.dart';
import 'package:chat/screens/components/new_message.dart';
import 'package:chat/screens/pages/notification_page.dart';
import 'package:chat/screens/utils/user_image_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Row(children: [
                    const Icon(
                      Icons.exit_to_app,
                      color: Colors.black,
                    ),
                    SizedBox(width: 2.w),
                    const Text('Logout'),
                  ]),
                )
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  AuthService().logout();
                }
              },
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: NotificationsButton(),
          ),
          const UserAction(),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: const [
            Expanded(child: Messages()),
            NewMessage()
          ],
        ),
      ),
    );
  }
}

class UserAction extends StatelessWidget {
  const UserAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;
    final userImage = UserImageHelper(url: currentUser!.imageUrl, maxRadius: 4.w);

    return Container(
      padding: EdgeInsets.only(right: 2.w, left: 2.w),
      child: userImage.image(),
    );
  }
}

class NotificationsButton extends StatelessWidget {
  const NotificationsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isThereAnyNotification() {
      return Provider.of<ChatNotificationService>(context).itemsCount > 0;
    }

    String notificationsCount() {
      final count = Provider.of<ChatNotificationService>(context).itemsCount;
      if (count <= 9) {
        return count.toString();
      } else {
        return '+9';
      }
    }

    return Stack(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return const NotificationPage();
              }),
            );
          },
          icon: Icon(isThereAnyNotification() ? Icons.notifications : Icons.notifications_none),
        ),
        Positioned(
          top: 1.5.w,
          right: 1.5.w,
          child: CircleAvatar(
            backgroundColor: Colors.red.shade800,
            maxRadius: 2.2.w,
            child: Text(
              notificationsCount(),
              style: TextStyle(
                fontSize: 9.sp,
              ),
            ),
          ),
        )
      ],
    );
  }
}
