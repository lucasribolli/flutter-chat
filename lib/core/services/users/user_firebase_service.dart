import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/users/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirebaseService implements UserService {
  static const String _usersDoc = 'users';

  @override
  Future<void> save(ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection(_usersDoc).doc(user.id);

    await docRef.set(user.toMap());
  }
}
