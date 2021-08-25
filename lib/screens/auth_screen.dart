import 'package:chat/models/auth_data.dart';
import 'package:chat/models/user_data.dart';
import 'package:chat/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  late bool _isLoading;

  _showSnackBarError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
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
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: userData.email,
          password: authData.password,
        );

        await FirebaseFirestore.instance
            .collection('user')
            .doc(
              userCredential.user!.uid,
            )
            .set(
              userData.toMap(),
            );
      }
    } catch (error) {
      _showSnackBarError(error.toString());
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
    );
  }
}
