import 'package:flutter/material.dart';
import 'package:saasfork_design_system/atoms/forms/form_message.dart';
import 'package:saasfork_design_system/foundations/colors.dart';
import 'package:saasfork_design_system/foundations/spacing.dart';

class SFFormfield extends StatelessWidget {
  final String? label;
  final Widget input;
  final String? hintMessage;
  final String? errorMessage;
  final bool isRequired;

  const SFFormfield({
    super.key,
    this.label,
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
        if (label != null && label!.isNotEmpty)
          Text(
            '$label${isRequired ? " *" : ""}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
              color:
                  errorMessage != null && errorMessage!.isNotEmpty
                      ? AppColors.red.s400
                      : Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        input,
        SFFormMessage(errorMessage: errorMessage, hintMessage: hintMessage),
      ],
    );
  }
}
