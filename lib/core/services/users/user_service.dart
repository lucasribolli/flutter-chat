import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/users/user_firebase_service.dart';

abstract class UserService {
  Future<void> save(ChatUser user);

  factory UserService() {
    return UserFirebaseService();
  }
}
