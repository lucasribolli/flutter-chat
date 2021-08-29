import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> backgroundNotificationHandler(RemoteMessage message) async {
  print('Notification called when app is in background or terminated');
}