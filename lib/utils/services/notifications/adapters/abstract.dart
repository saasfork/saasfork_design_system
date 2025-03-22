import 'package:flutter/material.dart';

abstract class NotificationAdapter {
  bool canHandle(Widget notification);

  Widget adaptNotification(Widget notification, VoidCallback closeCallback);
}
