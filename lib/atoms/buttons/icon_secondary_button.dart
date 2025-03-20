import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/foundations.dart';

class SFSecondaryIconButton extends StatelessWidget {
  final IconData icon;
  final ComponentSize size;
  final VoidCallback onPressed;
  final Color? iconColor;
  final String? label;
  final IconPosition iconPosition;

  const SFSecondaryIconButton({
    required this.icon,
    required this.onPressed,
    this.size = ComponentSize.md,
    this.iconColor,
    this.label,
    this.iconPosition = IconPosition.start,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: _getButtonStyle(context),
      child: _buildButtonContent(context),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final defaultIconColor = isDarkMode ? Colors.white : Colors.grey.shade700;

    final iconWidget = Icon(
      icon,
      color: iconColor ?? defaultIconColor,
      size: AppSizes.getIconSize(size),
    );

    if (label == null) {
      return iconWidget;
    }

    final textWidget = Text(
      label!,
      style: AppTypography.getScaledStyle(AppTypography.labelLarge, size),
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

    return theme?.copyWith(
      backgroundColor:
          Theme.of(context).outlinedButtonTheme.style!.backgroundColor,
      padding: WidgetStateProperty.all(_getButtonPadding()),
      minimumSize: WidgetStateProperty.all(
        label != null ? null : _getButtonSize(),
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
  }

  EdgeInsetsGeometry _getButtonPadding() {
    if (label != null) {
      return AppSizes.getPadding(size);
    }

    switch (size) {
      case ComponentSize.xs:
        return const EdgeInsets.all(4);
      case ComponentSize.sm:
        return const EdgeInsets.all(6);
      case ComponentSize.md:
        return const EdgeInsets.all(8);
      case ComponentSize.lg:
        return const EdgeInsets.all(10);
      case ComponentSize.xl:
        return const EdgeInsets.all(12);
    }
  }

  Size _getButtonSize() {
    switch (size) {
      case ComponentSize.xs:
        return const Size(16, 16);
      case ComponentSize.sm:
        return const Size(32, 32);
      case ComponentSize.md:
        return const Size(36, 36);
      case ComponentSize.lg:
        return const Size(40, 40);
      case ComponentSize.xl:
        return const Size(48, 48);
    }
  }
}
