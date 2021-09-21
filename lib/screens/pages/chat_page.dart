import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/screens/components/messages.dart';
import 'package:chat/screens/components/new_message.dart';
import 'package:chat/screens/utils/user_image_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
          actions: [
            DropdownButton(
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
            const UserImage(),
          ],
        ),
        body: SafeArea(
            child: Column(
          children: const [
            Expanded(child: Messages()),
            NewMessage()
          ],
        )));
  }
}

class UserImage extends StatelessWidget {
  const UserImage({Key? key}) : super(key: key);

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
