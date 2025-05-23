import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/foundations.dart';

class SFSecondaryIconButton extends StatelessWidget {
  final IconData icon;
  final ComponentSize size;
  final VoidCallback onPressed;
  final Color? iconColor;
  final String? label;
  final IconPosition iconPosition;
  final bool disabled;

  const SFSecondaryIconButton({
    required this.icon,
    required this.onPressed,
    this.size = ComponentSize.md,
    this.iconColor,
    this.label,
    this.iconPosition = IconPosition.start,
    this.disabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: disabled ? null : onPressed,
      style: _getButtonStyle(context),
      child: _buildButtonContent(context),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final defaultIconColor = isDarkMode ? Colors.white : Colors.grey.shade700;
    final Color effectiveIconColor =
        disabled ? AppColors.grey.s400 : (iconColor ?? defaultIconColor);

    final iconWidget = Icon(
      icon,
      color: effectiveIconColor,
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
    final theme = Theme.of(context).outlinedButtonTheme.style;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final baseStyle = theme?.copyWith(
      backgroundColor:
          Theme.of(context).outlinedButtonTheme.style!.backgroundColor,
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
      side: WidgetStateProperty.all(
        isDarkMode ? BorderSide.none : BorderSide(color: Colors.grey.shade400),
      ),
    );

    if (disabled) {
      return baseStyle?.copyWith(
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        side: WidgetStateProperty.all(BorderSide(color: AppColors.grey.s300)),
      );
    }

    return baseStyle;
  }
}
