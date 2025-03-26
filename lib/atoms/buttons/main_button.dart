import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFMainButton extends StatelessWidget {
  final String label;
  final ComponentSize size;
  final bool disabled;
  final VoidCallback? onPressed;
  final Color? color;

  const SFMainButton({
    required this.label,
    this.onPressed,
    this.size = ComponentSize.md,
    this.color,
    this.disabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      style: _getButtonStyle(context),
      child: Text(
        label,
        style: AppTypography.getScaledStyle(
          AppTypography.labelLarge,
          size,
        ).copyWith(color: disabled ? AppColors.grey.s400 : null),
      ),
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

    // Appliquer le style pour l'état disabled
    if (disabled) {
      return baseStyle?.copyWith(
        backgroundColor: WidgetStateProperty.all(AppColors.grey.s200),
        side: WidgetStateProperty.all(BorderSide(color: AppColors.grey.s200)),
      );
    }

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
