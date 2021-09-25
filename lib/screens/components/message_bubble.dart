import 'package:chat/core/models/chat_message.dart';
import 'package:chat/screens/utils/user_image_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool belongsToCurrentUser;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.belongsToCurrentUser,
  }) : super(key: key);

  Widget _getUserImage() {
    final imageHelper = UserImageHelper(
      url: message.userImageUrl,
      maxRadius: 4.w,
    );
    return Container(
      margin: _getImageMargin(),
      child: imageHelper.image(),
    );
  }

  EdgeInsets _getImageMargin() {
    return belongsToCurrentUser ? EdgeInsets.only(right: 1.5.w) : EdgeInsets.only(left: 1.5.w);
  }

  Color _getMessageColor(BuildContext context) {
    return belongsToCurrentUser ? Colors.grey.shade300 : Theme.of(context).colorScheme.secondary;
  }

  MainAxisAlignment _getAlignment() {
    return belongsToCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start;
  }

  Color _getNameTextColor() {
    return belongsToCurrentUser ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: _getAlignment(),
      children: [
        Row(
          children: [
            if (!belongsToCurrentUser) _getUserImage(),
            Container(
              decoration: BoxDecoration(
                color: _getMessageColor(context),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.h),
                ),
              ),
              constraints: BoxConstraints(maxWidth: 60.w),
              // width: 60.w,
              padding: EdgeInsets.symmetric(
                horizontal: 4.w,
                vertical: 2.w,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 2.w,
                vertical: 1.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!belongsToCurrentUser)
                    Text(
                      message.userName,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: _getNameTextColor(),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  Text(
                    message.text,
                    textAlign: belongsToCurrentUser ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                      color: _getNameTextColor(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
