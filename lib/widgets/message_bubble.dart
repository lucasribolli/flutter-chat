import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MessageBubble extends StatelessWidget {
  final Key? key;
  final String message;
  final bool belongsToMe;
  final String userName;

  const MessageBubble({
    required this.message,
    required this.belongsToMe,
    required this.userName,
    this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? myMessageColor() {
      return belongsToMe ? Colors.black : Theme.of(context).accentTextTheme.headline1!.color;
    }

    return Row(
      mainAxisAlignment: belongsToMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: belongsToMe ? Colors.grey[300] : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6.sp),
              topRight: Radius.circular(6.sp),
              bottomLeft: belongsToMe ? Radius.circular(6.sp) : Radius.circular(0),
              bottomRight: belongsToMe ? Radius.circular(0) : Radius.circular(6.sp),
            ),
          ),
          constraints: BoxConstraints(
            maxWidth: 75.w,
          ),
          // width: _getWidthFromMessage(),
          padding: EdgeInsets.symmetric(
            vertical: 1.5.h,
            horizontal: 3.w,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 0.5.h,
            horizontal: 3.w,
          ),
          child: Column(
            crossAxisAlignment: belongsToMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: myMessageColor(),
                ),
              ),
              Text(
                message,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: myMessageColor(),
                ),
                textAlign: belongsToMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
