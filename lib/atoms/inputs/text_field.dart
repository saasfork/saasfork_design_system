import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFTextField extends StatelessWidget {
  final String placeholder;
  final bool? isInError;
  final ComponentSize size;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Color? backgroundColor;
  final String? prefixText;
  final Widget? suffixWidget;

  const SFTextField({
    required this.placeholder,
    this.isInError = false,
    this.size = ComponentSize.md,
    this.controller,
    this.focusNode,
    this.backgroundColor,
    this.prefixText,
    this.suffixWidget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = theme.inputDecorationTheme;

    // Optimisation des calculs de base
    final bool hasError = isInError == true;
    final bool hasPrefix = prefixText != null && prefixText!.isNotEmpty;
    final bool hasSuffix = suffixWidget != null;

    // Récupérer le border radius depuis le thème de manière sécurisée
    final double borderRadius =
        inputTheme.enabledBorder is OutlineInputBorder
            ? (inputTheme.enabledBorder as OutlineInputBorder)
                .borderRadius
                .topLeft
                .x
            : AppSpacing.sm;

    // Configuration des styles de texte
    final textStyle = AppTypography.getScaledStyle(
      AppTypography.bodyLarge,
      size,
    );

    // Déterminer la couleur pour l'état d'erreur de manière sécurisée
    final Color errorColor =
        inputTheme.errorBorder is OutlineInputBorder
            ? (inputTheme.errorBorder as OutlineInputBorder).borderSide.color
            : AppColors.red.s300;

    // Style pour le hint et le préfixe
    final hintStyle =
        hasError
            ? textStyle.copyWith(color: errorColor)
            : textStyle.copyWith(color: inputTheme.hintStyle?.color);

    // Bordures selon l'état avec valeurs par défaut
    final InputBorder defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    );

    final InputBorder defaultErrorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: errorColor),
    );

    final InputBorder activeBorder =
        hasError
            ? (inputTheme.errorBorder ?? defaultErrorBorder)
            : (inputTheme.enabledBorder ?? defaultBorder);

    final InputBorder focusedBorder =
        hasError
            ? (inputTheme.focusedErrorBorder ?? defaultErrorBorder)
            : (inputTheme.focusedBorder ?? defaultBorder);

    // Couleur de fond du préfixe
    final Color prefixBackgroundColor =
        hasError ? AppColors.red.s50 : AppColors.gray.s50;

    return TextField(
      controller: controller,
      style: textStyle,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: hintStyle,
        contentPadding: AppSizes.getInputPadding(size),
        constraints: AppSizes.getInputConstraints(size),
        enabledBorder: activeBorder,
        focusedBorder: focusedBorder,
        filled: backgroundColor != null || inputTheme.filled == true,
        fillColor: backgroundColor ?? inputTheme.fillColor,
        prefixIcon:
            hasPrefix
                ? _buildPrefix(
                  borderRadius: borderRadius,
                  style: hintStyle,
                  backgroundColor: prefixBackgroundColor,
                )
                : null,
        suffixIcon: hasSuffix ? suffixWidget : null,
        disabledBorder: inputTheme.disabledBorder ?? defaultBorder,
        border: inputTheme.border ?? defaultBorder,
      ),
    );
  }

  // Méthode extraite pour construire le préfixe
  Widget _buildPrefix({
    required double borderRadius,
    required TextStyle? style,
    required Color backgroundColor,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      widthFactor: 1.0,
      child: Container(
        margin: const EdgeInsets.only(left: 1),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            bottomLeft: Radius.circular(borderRadius),
          ),
        ),
        child: Text(prefixText!, style: style),
      ),
    );
  }
}
