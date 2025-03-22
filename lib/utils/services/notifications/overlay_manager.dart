import 'package:flutter/material.dart';
import 'package:saasfork_design_system/utils/services/notification_service.dart';
import 'package:saasfork_design_system/utils/services/notifications/abstract.dart';
import 'package:saasfork_design_system/utils/services/notifications/animated_notification.dart';
import 'package:saasfork_design_system/utils/services/notifications/providers/time_provider.dart';

class OverlayNotificationManager implements NotificationManager {
  final TimerProvider _timerProvider;
  final List<OverlayEntry> _activeEntries = [];

  OverlayNotificationManager({TimerProvider? timerProvider})
    : _timerProvider = timerProvider ?? RealTimerProvider();

  @override
  void show(
    BuildContext context,
    Widget notification, {
    Duration duration = const Duration(seconds: 4),
    EdgeInsets margin = const EdgeInsets.only(top: 16, right: 16),
    bool requireSafeArea = true,
    VoidCallback? onClosed,
  }) {
    final overlayState = Overlay.of(context);
    final currentTheme = Theme.of(context);

    late OverlayEntry overlayEntry;
    AnimatedNotificationState? animationState;

    // On utilise cette fonction comme "pont" entre l'adaptateur et l'état d'animation
    void closeAnimatedNotification() {
      if (animationState != null) {
        animationState!.closeNotification();
      }
    }

    // Adaptez la notification en lui passant un callback de fermeture
    // Mais on garde cette logique dans NotificationService
    final adaptedNotification = NotificationService()
        .adaptNotificationWithCallback(notification, closeAnimatedNotification);

    // Créer l'overlay
    overlayEntry = OverlayEntry(
      builder: (context) {
        Widget notificationWidget = Theme(
          data: currentTheme,
          child: Material(
            type: MaterialType.transparency,
            child: AnimatedNotification(
              duration: duration,
              timerProvider: _timerProvider,
              onClose: () {
                if (overlayEntry.mounted) {
                  overlayEntry.remove();
                  _activeEntries.remove(overlayEntry);
                  if (onClosed != null) {
                    onClosed();
                  }
                }
              },
              onStateCreated: (state) {
                animationState = state;
              },
              child: adaptedNotification,
            ),
          ),
        );

        if (requireSafeArea) {
          notificationWidget = SafeArea(child: notificationWidget);
        }

        return Positioned(
          top: margin.top,
          right: margin.right,
          child: notificationWidget,
        );
      },
    );

    overlayState.insert(overlayEntry);
    _activeEntries.add(overlayEntry);

    // Timer pour fermer automatiquement
    _timerProvider.createTimer(duration, () {
      if (animationState != null && !animationState!.isClosing) {
        animationState!.closeNotification();
      }
    });
  }

  @override
  void closeAll() {
    for (final entry in List.from(_activeEntries)) {
      if (entry.mounted) {
        entry.remove();
      }
    }
    _activeEntries.clear();
  }
}
