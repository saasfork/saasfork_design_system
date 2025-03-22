import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saasfork_core/saasfork_core.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class NotificationWrapper extends ConsumerWidget {
  final Widget child;

  const NotificationWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<NotificationState>(notificationProvider, (previous, current) {
      if (current.hasNotification && current.message != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          switch (current.type) {
            case NotificationType.success:
              context.showSuccess(
                message: current.message!,
                title: current.title,
              );
              break;
            case NotificationType.error:
              context.showError(
                message: current.message!,
                title: current.title,
              );
              break;
            case NotificationType.warning:
              context.showWarning(
                message: current.message!,
                title: current.title,
              );
              break;
            case NotificationType.info:
              context.showInfo(message: current.message!, title: current.title);
              break;
          }
          ref.read(notificationProvider.notifier).clear();
        });
      }
    });

    return child;
  }
}
