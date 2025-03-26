import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFIconButton extends StatelessWidget {
  final IconData icon;
  final ComponentSize size;
  final VoidCallback onPressed;
  final Color? iconColor;
  final Color? buttonColor;
  final String? label;
  final IconPosition iconPosition;
  final bool disabled;

  const SFIconButton({
    required this.icon,
    required this.onPressed,
    this.size = ComponentSize.md,
    this.iconColor,
    this.buttonColor,
    this.label,
    this.iconPosition = IconPosition.start,
    this.disabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      style: _getButtonStyle(context),
      child: _buildButtonContent(context),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    final iconWidget = Icon(
      icon,
      color: disabled ? AppColors.grey.s400 : (iconColor ?? Colors.white),
      size: AppSizes.getIconSize(size),
    );

    if (label == null) {
      return iconWidget;
    }

    final textWidget = Text(
      label!,
      style: AppTypography.getScaledStyle(
        AppTypography.labelLarge,
        size,
      ).copyWith(color: disabled ? AppColors.grey.s400 : null),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (iconPosition == IconPosition.start) iconWidget,
        if (iconPosition == IconPosition.start && label != null)
          SizedBox(width: AppSpacing.xs),
        if (label != null) textWidget,
        if (iconPosition == IconPosition.end && label != null)
          SizedBox(width: AppSpacing.xs),
        if (iconPosition == IconPosition.end) iconWidget,
      ],
    );
  }

  ButtonStyle? _getButtonStyle(BuildContext context) {
    final theme = Theme.of(context).elevatedButtonTheme.style;

    final baseStyle = theme?.copyWith(
      padding: WidgetStateProperty.all(
        label == null
            ? AppSizes.getButtonPadding(size)
            : AppSizes.getPadding(size),
      ),
      minimumSize: WidgetStateProperty.all(
        label != null ? null : AppSizes.getButtonSize(size),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.sm),
        ),
      ),
    );

    // Appliquer le style pour l'état disabled
    if (disabled) {
      return baseStyle?.copyWith(
        backgroundColor: WidgetStateProperty.all(AppColors.grey.s200),
        side: WidgetStateProperty.all(BorderSide(color: AppColors.grey.s200)),
      );
    }

    // Appliquer la couleur personnalisée du bouton si spécifiée
    if (buttonColor != null) {
      return baseStyle?.copyWith(
        backgroundColor: WidgetStateProperty.all(buttonColor),
        side: WidgetStateProperty.all(BorderSide(color: buttonColor!)),
      );
    }

    return baseStyle;
  }
}
