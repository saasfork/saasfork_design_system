import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFPasswordField extends StatefulWidget {
  final String placeholder;
  final bool? isInError;
  final ComponentSize size;
  final TextEditingController controller;

  const SFPasswordField({
    required this.placeholder,
    this.isInError = false,
    this.size = ComponentSize.md,
    required this.controller,
    super.key,
  });

  @override
  State<SFPasswordField> createState() => _SFPasswordFieldState();
}

class _SFPasswordFieldState extends State<SFPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = theme.inputDecorationTheme;
    final inputPadding = AppSizes.getInputPadding(widget.size);

    final TextStyle? errorHintStyle = inputTheme.hintStyle?.copyWith(
      color:
          inputTheme.errorBorder is OutlineInputBorder
              ? (inputTheme.errorBorder as OutlineInputBorder).borderSide.color
              : AppColors.red.s300,
    );

    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      style: AppTypography.getScaledStyle(AppTypography.bodyLarge, widget.size),
      decoration: InputDecoration(
        hintText: widget.placeholder,
        hintStyle:
            widget.isInError == true
                ? errorHintStyle
                : AppTypography.getScaledStyle(
                  AppTypography.bodyLarge,
                  widget.size,
                ).copyWith(color: inputTheme.hintStyle?.color),
        contentPadding: inputPadding,
        constraints: AppSizes.getInputConstraints(widget.size),
        enabledBorder:
            widget.isInError == true
                ? theme.inputDecorationTheme.errorBorder
                : theme.inputDecorationTheme.enabledBorder,
        focusedBorder:
            widget.isInError == true
                ? theme.inputDecorationTheme.focusedErrorBorder
                : theme.inputDecorationTheme.focusedBorder,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            size: AppSizes.getIconSize(widget.size),
          ),
          onPressed: () => setState(() => _obscureText = !_obscureText),
        ),
      ),
    );
  }
}
