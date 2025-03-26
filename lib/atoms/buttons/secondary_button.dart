import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFSecondaryButton extends StatelessWidget {
  final String label;
  final ComponentSize size;
  final VoidCallback onPressed;
  final bool disabled;

  const SFSecondaryButton({
    required this.label,
    required this.onPressed,
    this.size = ComponentSize.md,
    this.disabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: disabled ? null : onPressed,
      style: _getButtonStyle(context),
      child: Text(
        label,
        style:
            disabled
                ? AppTypography.getScaledStyle(
                  AppTypography.labelLarge,
                  size,
                ).copyWith(color: AppColors.grey.s400)
                : null,
      ),
    );
  }

  ButtonStyle? _getButtonStyle(BuildContext context) {
    final theme = Theme.of(context).outlinedButtonTheme.style;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final baseStyle = theme?.copyWith(
      padding: WidgetStateProperty.all(AppSizes.getPadding(size)),
      textStyle: WidgetStateProperty.all(
        AppTypography.getScaledStyle(AppTypography.labelLarge, size),
      ),
      side: WidgetStateProperty.all(
        isDarkMode ? BorderSide.none : BorderSide(color: Colors.grey.shade400),
      ),
    );

    // Appliquer le style pour l'état disabled
    if (disabled) {
      return baseStyle?.copyWith(
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        side: WidgetStateProperty.all(BorderSide(color: AppColors.grey.s300)),
      );
    }

    return baseStyle;
  }
}
