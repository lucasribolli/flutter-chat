import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.purple.withAlpha(700),
            borderRadius: BorderRadius.circular(5.sp),
          ), 
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          child: Text(
            'Flutter Chat',
            style: TextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 3.sp,
              color: Colors.white
            ),           
          ),
        ),
      ),
    );
  }
}