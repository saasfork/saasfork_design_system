import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFTextField extends StatelessWidget {
  final String placeholder;
  final bool? isInError;
  final ComponentSize size;
  final TextEditingController? controller;

  const SFTextField({
    required this.placeholder,
    this.isInError = false,
    this.size = ComponentSize.md,
    this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = theme.inputDecorationTheme;
    final inputPadding = AppSizes.getInputPadding(size);

    final TextStyle? errorHintStyle = inputTheme.hintStyle?.copyWith(
      color:
          inputTheme.errorBorder is OutlineInputBorder
              ? (inputTheme.errorBorder as OutlineInputBorder).borderSide.color
              : AppColors.red.s300,
    );

    return TextField(
      controller: controller,
      style: AppTypography.getScaledStyle(AppTypography.bodyLarge, size),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle:
            isInError == true
                ? errorHintStyle
                : AppTypography.getScaledStyle(
                  AppTypography.bodyLarge,
                  size,
                ).copyWith(color: inputTheme.hintStyle?.color),
        contentPadding: inputPadding,
        constraints: AppSizes.getInputConstraints(size),
        enabledBorder:
            isInError == true
                ? theme.inputDecorationTheme.errorBorder
                : theme.inputDecorationTheme.enabledBorder,
        focusedBorder:
            isInError == true
                ? theme.inputDecorationTheme.focusedErrorBorder
                : theme.inputDecorationTheme.focusedBorder,
      ),
    );
  }
}
