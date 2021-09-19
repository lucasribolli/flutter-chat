import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
              SizedBox(height: 2.h),
              const Text(
                'Loading...',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}