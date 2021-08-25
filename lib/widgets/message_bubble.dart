import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MessageBubble extends StatelessWidget {
  final String message;

  const MessageBubble({
    required this.message,
  });

  double _getWidgetFromMessage() {
    int chars = message.length;
    return (chars.toDouble() * 3.w) + 4.8.w;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(5.sp),
          ),
          width: _getWidgetFromMessage(),
          padding: EdgeInsets.symmetric(
            vertical: 1.5.h,
            horizontal: 3.w,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 0.5.h,
            horizontal: 3.w,
          ),
          child: Text(
            message,
            style: TextStyle(
              fontSize: 12.sp,
              color: Theme.of(context).accentTextTheme.headline1!.color,
            ),
          ),
        ),
      ],
    );
  }
}
