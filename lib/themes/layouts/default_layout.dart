import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saasfork_design_system/themes/wrappers/notification_wrapper.dart';

class SFDefaultLayout extends ConsumerWidget {
  final Widget child;

  const SFDefaultLayout({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationWrapper(child: child);
  }
}
