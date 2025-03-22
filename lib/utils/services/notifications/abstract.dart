import 'package:flutter/material.dart';

abstract class NotificationManager {
  void show(
    BuildContext context,
    Widget notification, {
    Duration duration,
    EdgeInsets margin,
    bool requireSafeArea,
    VoidCallback? onClosed,
  });

  void closeAll();
}


