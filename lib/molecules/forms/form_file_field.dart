import 'package:flutter/material.dart';
import 'package:saasfork_design_system/atoms/forms/form_message.dart';
import 'package:saasfork_design_system/foundations/spacing.dart';

class SFFormFilefield extends StatelessWidget {
  final Widget input;
  final String? hintMessage;
  final String? errorMessage;
  final bool isRequired;

  const SFFormFilefield({
    super.key,
    required this.input,
    this.hintMessage,
    this.errorMessage,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.sm,
      children: [
        input,
        SFFormMessage(
          errorMessage: errorMessage,
          hintMessage: isRequired ? "$hintMessage *" : hintMessage,
        ),
      ],
    );
  }
}
