import 'package:flutter/material.dart';
import 'package:saasfork_design_system/utils/services/notifications/abstract.dart';
import 'package:saasfork_design_system/utils/services/notifications/adapters/abstract.dart';
import 'package:saasfork_design_system/utils/services/notifications/adapters/notification_adapter.dart';
import 'package:saasfork_design_system/utils/services/notifications/overlay_manager.dart';

class NotificationService {
  final NotificationManager _manager;
  final List<NotificationAdapter> _adapters = [];

  NotificationService.internal(this._manager) {
    // Enregistrer les adaptateurs par défaut directement ici
    registerAdapter(SFNotificationAdapter());
  }

  static NotificationService _instance = NotificationService.internal(
    OverlayNotificationManager(),
  );

  factory NotificationService() => _instance;

  static void setInstance(NotificationService instance) {
    _instance = instance;
  }

  /// Enregistre un nouvel adaptateur de notification
  void registerAdapter(NotificationAdapter adapter) {
    _adapters.add(adapter);
  }

  /// Trouve un adaptateur compatible avec la notification donnée
  NotificationAdapter? _findAdapterFor(Widget notification) {
    for (var adapter in _adapters) {
      if (adapter.canHandle(notification)) {
        return adapter;
      }
    }
    return null;
  }

  /// Adapte une notification si un adaptateur compatible existe
  Widget _adaptNotification(Widget notification, VoidCallback closeCallback) {
    final adapter = _findAdapterFor(notification);
    if (adapter != null) {
      return adapter.adaptNotification(notification, closeCallback);
    }
    return notification;
  }

  /// Adapte une notification avec un callback de fermeture spécifique
  /// Cette méthode est utilisée par OverlayNotificationManager
  Widget adaptNotificationWithCallback(
    Widget notification,
    VoidCallback closeCallback,
  ) {
    final adapter = _findAdapterFor(notification);
    if (adapter != null) {
      return adapter.adaptNotification(notification, closeCallback);
    }
    return notification;
  }

  void showNotification(
    BuildContext context,
    Widget notification, {
    Duration duration = const Duration(seconds: 4),
    EdgeInsets margin = const EdgeInsets.only(top: 16, right: 16),
    bool requireSafeArea = true,
    VoidCallback? onClosed,
  }) {
    // Adapter la notification avant de l'envoyer au manager
    final adaptedNotification = _adaptNotification(notification, () {
      // Ce callback sera appelé lorsque l'animation de fermeture est terminée
      if (onClosed != null) {
        onClosed();
      }
    });

    _manager.show(
      context,
      adaptedNotification,
      duration: duration,
      margin: margin,
      requireSafeArea: requireSafeArea,
    );
  }

  void closeAllNotifications() {
    _manager.closeAll();
  }
}
