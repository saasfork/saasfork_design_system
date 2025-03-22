import 'package:flutter/material.dart';
import 'package:saasfork_design_system/molecules/molecules.dart';
import 'package:saasfork_design_system/utils/services/notifications/adapters/abstract.dart';

/// Adaptateur pour les notifications de type [SFNotification].
///
/// Cet adaptateur permet d'intégrer les notifications [SFNotification] dans le système
/// de gestion de notifications en s'assurant que les rappels de fermeture sont correctement gérés.
class SFNotificationAdapter implements NotificationAdapter {
  /// Vérifie si cette notification peut être gérée par cet adaptateur.
  ///
  /// Retourne `true` si la [notification] est de type [SFNotification].
  @override
  bool canHandle(Widget notification) {
    return notification is SFNotification;
  }

  /// Adapte la notification pour assurer la gestion correcte des rappels de fermeture.
  ///
  /// [notification] - La notification à adapter.
  /// [closeCallback] - Fonction à appeler lorsque la notification est fermée.
  ///
  /// Retourne une instance de [SFNotification] adaptée avec le gestionnaire de fermeture modifié
  /// pour appeler à la fois le callback original et le callback de fermeture fourni.
  @override
  Widget adaptNotification(Widget notification, VoidCallback closeCallback) {
    if (notification is! SFNotification) {
      return notification;
    }

    final originalOnClose = notification.onClose;

    return SFNotification(
      title: notification.title,
      message: notification.message,
      icon: notification.icon,
      iconColor: notification.iconColor,
      onClose: () {
        if (originalOnClose != null) {
          originalOnClose();
        }

        closeCallback();
      },
    );
  }
}
