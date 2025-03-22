import 'package:flutter/material.dart';
import 'package:saasfork_design_system/utils/services/notifications/adapters/abstract.dart';

/// Registre des adaptateurs de notification disponibles
class NotificationAdapterRegistry {
  static final NotificationAdapterRegistry _instance =
      NotificationAdapterRegistry._();

  factory NotificationAdapterRegistry() => _instance;

  NotificationAdapterRegistry._();

  final List<NotificationAdapter> _adapters = [];

  /// Enregistre un nouvel adaptateur dans le registre
  void registerAdapter(NotificationAdapter adapter) {
    _adapters.add(adapter);
  }

  /// Trouve un adaptateur capable de gérer le widget donné ou retourne null
  NotificationAdapter? findAdapterFor(Widget notification) {
    for (final adapter in _adapters) {
      if (adapter.canHandle(notification)) {
        return adapter;
      }
    }
    return null;
  }

  /// Adapte une notification si un adaptateur est disponible, sinon retourne l'original
  Widget adaptNotification(Widget notification, VoidCallback closeCallback) {
    final adapter = findAdapterFor(notification);
    if (adapter != null) {
      return adapter.adaptNotification(notification, closeCallback);
    }
    return notification;
  }

  void clearAdapters() {
    _adapters.clear();
  }
}
