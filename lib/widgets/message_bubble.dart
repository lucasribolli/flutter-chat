import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MessageBubble extends StatelessWidget {
  final Key? key;
  final String message;
  final bool belongsToMe;
  final String userName;
  final String userImage;

  const MessageBubble({
    required this.message,
    required this.belongsToMe,
    required this.userName,
    required this.userImage,
    this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: belongsToMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if(!belongsToMe) AnotherUserPicture(userImage),
        MessageText(
          belongsToMe: belongsToMe,
          message: message,
          userImage: userImage,
          userName: userName,
          key: key,
        ),
        if(belongsToMe) MyPicture(userImage),
      ],
    );
  }
}

class MyPicture extends StatelessWidget {
  final String userImage;

  MyPicture(this.userImage);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1.w),
      child: CircleAvatar(),
    );
  }
}

class AnotherUserPicture extends StatelessWidget {
  final String userImage;

  AnotherUserPicture(this.userImage);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.w),
      child: UserPicture(userImage),
    );
  }
}

class UserPicture extends StatelessWidget {
  final String userImage;

  UserPicture(this.userImage);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(this.userImage),
    );
  }
}

class MessageText extends StatelessWidget {
  final Key? key;
  final String message;
  final bool belongsToMe;
  final String userName;
  final String userImage;

  const MessageText({
    required this.message,
    required this.belongsToMe,
    required this.userName,
    required this.userImage,
    this.key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Color? myMessageColor() {
      return belongsToMe ? Colors.black : Theme.of(context).accentTextTheme.headline1!.color;
    }

    return Container(
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
      padding: EdgeInsets.symmetric(
        vertical: 1.5.h,
        horizontal: 3.w,
      ),
      margin: EdgeInsets.symmetric(
        vertical: 1.5.h,
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
    );
  }
}
