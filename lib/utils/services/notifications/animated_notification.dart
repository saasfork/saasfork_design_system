import 'dart:async';

import 'package:flutter/material.dart';
import 'package:saasfork_design_system/utils/services/notifications/providers/time_provider.dart';

/// Widget qui anime l'entrée et la sortie d'une notification
class AnimatedNotification extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final VoidCallback onClose;
  final Function(AnimatedNotificationState)? onStateCreated;
  final TimerProvider? timerProvider;

  const AnimatedNotification({
    super.key,
    required this.child,
    required this.duration,
    required this.onClose,
    this.onStateCreated,
    this.timerProvider,
  });

  @override
  State<AnimatedNotification> createState() => AnimatedNotificationState();
}

class AnimatedNotificationState extends State<AnimatedNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slideAnimation;
  Timer? _timer;
  bool isClosing = false;
  late TimerProvider _timerProvider;

  @override
  void initState() {
    super.initState();
    _timerProvider = widget.timerProvider ?? RealTimerProvider();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    if (widget.onStateCreated != null) {
      widget.onStateCreated!(this);
    }
  }

  void closeNotification() {
    if (isClosing) return;
    isClosing = true;

    if (_timer != null) {
      _timerProvider.cancel(_timer!);
    }

    _controller.reverse().then((_) {
      widget.onClose();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    if (_timer != null) {
      _timerProvider.cancel(_timer!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _opacity,
        child: Material(
          color: Colors.transparent,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
