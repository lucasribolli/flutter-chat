import 'dart:io';

import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/auth/auth_mock_service.dart';

abstract class AuthService {
  ChatUser? get currentUser;
  Future<void> signup(
    String name,
    String email, 
    String password, 
    File? image
  );
  Future<void> login(String email, String password);
  Future<void> logout();
  Stream<ChatUser?> get userChanges;

  factory AuthService() {
    return AuthMockService();
  }
}