import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import 'package:chat/core/models/chat_notification.dart';

class ChatNotificationService extends ChangeNotifier {
  final List<ChatNotification> _items = [];

  List<ChatNotification> get items {
    return [
      ..._items
    ];
  }

  int get itemsCount {
    return _items.length;
  }

  void add(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i) {
    _items.removeAt(i);
    notifyListeners();
  }

  Future<void> init() async {
    await _configureForeground();
    await _configureBackground();
    await _configureTerminated();
  }

  Future<void> _configureBackground() async {
    if (await isAuthorized) {
      FirebaseMessaging.onMessageOpenedApp.listen(_messageHandler);
    }
  }

  Future<void> _configureTerminated() async {
    if (await isAuthorized) {
      RemoteMessage? initalMessage = await FirebaseMessaging.instance.getInitialMessage();
      _messageHandler(initalMessage);
    }
  }

  Future<void> _configureForeground() async {
    if (await isAuthorized) {
      FirebaseMessaging.onMessage.listen(_messageHandler);
    }
  }

  Future<bool> get isAuthorized async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  void _messageHandler(RemoteMessage? message) {
    if (message == null) {
      return;
    }
    if (message.notification == null) {
      return;
    }
    final notification = message.notification!;
    if (_notificationAlreadyExists(notification.title!)) {
      return;
    }
    add(ChatNotification(
      title: notification.title ?? 'Not know',
      body: notification.body ?? 'Not know',
    ));
  }

  bool _notificationAlreadyExists(String title) {
    for (final item in _items) {
      if (item.title == title) {
        return true;
      }
    }
    return false;
  }

  @override
  String toString() => 'ChatNotificationService(_items: $_items)';
}
