import 'dart:io';

import 'package:chat/models/auth_data.dart';
import 'package:chat/models/user_data.dart';
import 'package:chat/widgets/auth_form.dart';
import 'package:chat/widgets/utils/snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  late bool _isLoading;
  
  Future<Reference> _createUserPathIntoBucket(UserCredential userCredential) async {
    return FirebaseStorage.instance.ref().child('user_images').child(userCredential.user!.uid + '.jpg');
  }

  Future<void> _putFileIntoBucket(Reference ref, File? image) async {
    if(image != null) {
      await ref.putFile(image);
    }
  }

  Future<void> _handleSubmit(AuthData authData) async {
    setState(() {
      _isLoading = true;
    });
    try {      
      UserCredential userCredential;

      final userData = UserData(
        name: authData.name,
        email: authData.email.trim(),
      );

      if (authData.isLogin) {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: userData.email,
          password: authData.password,
        );
      } 
      else {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: userData.email,
          password: authData.password,
        );

        Reference userRef = await _createUserPathIntoBucket(userCredential);
        await _putFileIntoBucket(userRef, authData.image);
        final String imageBucketUrl = await userRef.getDownloadURL();

        userData.imageUrl = imageBucketUrl;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(
              userCredential.user!.uid,
            )
            .set(
              userData.toMap(),
            );
      }
    } catch (error) {
      SnackBarUtils.showSnackBarError(context, error.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  AuthForm(_handleSubmit),
                  if (_isLoading)
                    Positioned.fill(
                      right: 7.5.w,
                      left: 7.5.w,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
