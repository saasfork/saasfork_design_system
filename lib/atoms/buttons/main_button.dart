import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFMainButton extends StatelessWidget {
  final String label;
  final ComponentSize size;
  final VoidCallback onPressed;
  final Color? color;

  const SFMainButton({
    required this.label,
    required this.onPressed,
    this.size = ComponentSize.md,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _getButtonStyle(context),
      child: Text(label),
    );
  }

  ButtonStyle? _getButtonStyle(BuildContext context) {
    final theme = Theme.of(context).elevatedButtonTheme.style;

    final baseStyle = theme?.copyWith(
      padding: WidgetStateProperty.all(AppSizes.getPadding(size)),
      textStyle: WidgetStateProperty.all(
        AppTypography.getScaledStyle(AppTypography.labelLarge, size),
      ),
    );

    // Appliquer la couleur personnalisée si elle est fournie
    if (color != null) {
      return baseStyle?.copyWith(
        backgroundColor: WidgetStateProperty.all(color),
        side: WidgetStateProperty.all(BorderSide(color: color!)),
      );
    }

    return baseStyle;
  }
}
