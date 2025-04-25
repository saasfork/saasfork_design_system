import 'package:flutter/material.dart';
import 'package:saasfork_design_system/atoms/forms/form_message.dart';
import 'package:saasfork_design_system/atoms/inputs/switch_field.dart';
import 'package:saasfork_design_system/foundations/colors.dart';
import 'package:saasfork_design_system/foundations/spacing.dart';

class SFFormfield extends StatelessWidget {
  final String? label;
  final Widget? labelCustom;
  final Widget input;
  final String? hintMessage;
  final String? errorMessage;
  final bool isRequired;
  final bool useRowLayout;
  final MainAxisAlignment rowMainAxisAlignment;
  final CrossAxisAlignment rowCrossAxisAlignment;

  const SFFormfield({
    super.key,
    this.label,
    this.labelCustom,
    required this.input,
    this.hintMessage,
    this.errorMessage,
    this.isRequired = false,
    this.useRowLayout = false,
    this.rowMainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.rowCrossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSwitchField = input is SFSwitchField;
    final bool useRowForInput = useRowLayout || isSwitchField;

    final TextStyle labelStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
      color:
          errorMessage != null && errorMessage!.isNotEmpty
              ? AppColors.red.s400
              : Theme.of(context).textTheme.bodyLarge?.color,
    );

    Widget? labelWidget;

    if (label != null && label!.isNotEmpty) {
      labelWidget = Text('$label${isRequired ? " *" : ""}', style: labelStyle);
    } else if (labelCustom != null) {
      labelWidget = labelCustom;
    } else {
      labelWidget = null;
    }

    final Widget formMessage = SFFormMessage(
      errorMessage: errorMessage,
      hintMessage: hintMessage,
    );

    if (useRowForInput && labelWidget != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.sm,
        children: [
          Row(
            mainAxisAlignment: rowMainAxisAlignment,
            crossAxisAlignment: rowCrossAxisAlignment,
            children: [
              Expanded(flex: 1, child: labelWidget),

              isSwitchField ? input : Expanded(flex: 1, child: input),
            ],
          ),
          formMessage,
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.sm,
        children: [if (labelWidget != null) labelWidget, input, formMessage],
      );
    }
  }
}
