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

  @override
  String toString() => 'ChatNotificationService(_items: $_items)';
}
