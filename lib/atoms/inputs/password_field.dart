import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFPasswordField extends StatefulWidget {
  final String placeholder;
  final bool? isInError;
  final ComponentSize size;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextInputAction textInputAction;
  final Function(String)? onSubmitted;
  final String? semanticsLabel;
  final String? semanticsHint;
  final String? helperTextShowPassword;
  final String? helperTextHidePassword;

  const SFPasswordField({
    required this.placeholder,
    this.isInError = false,
    this.size = ComponentSize.md,
    required this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
    this.semanticsLabel,
    this.semanticsHint = 'Double-tap and hold to show password',
    this.helperTextShowPassword = 'Show Password',
    this.helperTextHidePassword = 'Hide Password',
    super.key,
  });

  @override
  State<SFPasswordField> createState() => _SFPasswordFieldState();
}

class _SFPasswordFieldState extends State<SFPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final iconSize = AppSizes.getIconSize(widget.size);
    final theme = Theme.of(context);

    final suffixWidget = IconButton(
      icon: Icon(
        _obscureText ? Icons.visibility_off : Icons.visibility,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        size: iconSize,
      ),
      tooltip:
          _obscureText
              ? widget.helperTextShowPassword
              : widget.helperTextHidePassword,
      onPressed: () => setState(() => _obscureText = !_obscureText),
    );

    return Semantics(
      hint: widget.semanticsHint,
      child: ExcludeSemantics(
        child: SFTextField(
          placeholder: widget.placeholder,
          isInError: widget.isInError,
          size: widget.size,
          controller: widget.controller,
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          textInputAction: widget.textInputAction,
          onSubmitted: widget.onSubmitted,
          semanticsLabel: widget.semanticsLabel,
          suffixWidget: suffixWidget,
          builder: (context, textField) {
            final tf = textField as TextField;
            return TextField(
              controller: tf.controller,
              focusNode: tf.focusNode,
              style: tf.style,
              decoration: tf.decoration,
              textInputAction: tf.textInputAction,
              onSubmitted: tf.onSubmitted,
              autofocus: tf.autofocus,
              obscureText: _obscureText,
            );
          },
        ),
      ),
    );
  }
}
