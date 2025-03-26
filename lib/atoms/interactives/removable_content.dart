import 'package:flutter/material.dart';

class RemovableContent extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPress;
  final double buttonSize;
  final Offset position;
  final IconData icon;
  final Color buttonColor;
  final Color iconColor;
  final bool disabled;

  const RemovableContent({
    super.key,
    required this.child,
    required this.onPress,
    this.buttonSize = 24.0,
    this.position = const Offset(-8, -8),
    this.icon = Icons.close,
    this.buttonColor = Colors.red,
    this.iconColor = Colors.white,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,

        if (onPress != null && !disabled)
          Positioned(
            top: position.dy,
            right: position.dx,
            child: InkWell(
              onTap: onPress,
              child: Container(
                width: buttonSize,
                height: buttonSize,
                decoration: BoxDecoration(
                  color: buttonColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(20),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(icon, color: iconColor, size: buttonSize * 0.6),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
