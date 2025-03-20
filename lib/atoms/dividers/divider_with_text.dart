import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFDividerWithText extends StatelessWidget {
  final String text;

  const SFDividerWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(color: Theme.of(context).dividerColor, thickness: 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Expanded(
          child: Divider(color: Theme.of(context).dividerColor, thickness: 1),
        ),
      ],
    );
  }
}
