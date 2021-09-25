import 'package:chat/core/models/chat_user.dart';
import 'dart:io';
import 'dart:async';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/users/user_firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class AuthFirebaseService implements AuthService {
  static ChatUser? _currentUser;

  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final Stream<User?> authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toChatUser(user);
      controller.add(_currentUser);
    }
  });

  static ChatUser _toChatUser(
    User user, [
    String? name,
    String? imageUrl,
  ]) {
    return ChatUser(
      id: user.uid,
      email: user.email!,
      name: name ?? user.displayName ?? user.email!.split('@').first,
      imageUrl: imageUrl ?? user.photoURL ?? 'assets/images/avatar.png',
    );
  }

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (_) {
      // TODO
    }
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signup(String name, String email, String password, File? image) async {
    try {
      final auth = FirebaseAuth.instance;
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.updateDisplayName(name);

      final imageName = '${credential.user!.uid}.jpg';
      final imageUrl = await _uploadUserImage(image, imageName);

      credential.user?.updateDisplayName(name);
      credential.user?.updatePhotoURL(imageUrl);

      _currentUser = _toChatUser(credential.user!, name, imageUrl);
      await UserFirebaseService().save(_currentUser!);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> _uploadUserImage(File? image, String imageName) async {
    if (image == null) {
      throw Exception("image is null");
    }
    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('user_images').child(imageName);
    await imageRef.putFile(image).whenComplete(() => null);
    return await imageRef.getDownloadURL();
  }

  @override
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }
}
