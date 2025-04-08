import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/colors.dart';

class SFSwitchField extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isDisabled;
  final Color? activeColor;
  final Color? inactiveThumbColor;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final String? tooltipMessage;

  const SFSwitchField({
    super.key,
    required this.value,
    required this.onChanged,
    this.isDisabled = false,
    this.activeColor,
    this.inactiveThumbColor,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.tooltipMessage = 'Ce champ est désactivé',
  });

  @override
  Widget build(BuildContext context) {
    final Color defaultActiveColor = activeColor ?? AppColors.indigo.s400;
    final Color defaultActiveTrackColor =
        activeTrackColor ?? AppColors.indigo.s100;

    final Widget switchWidget = Opacity(
      opacity: isDisabled ? 0.5 : 1.0,
      child: Switch(
        value: value,
        onChanged: isDisabled ? null : onChanged,
        activeColor: defaultActiveColor,
        activeTrackColor: defaultActiveTrackColor,
        inactiveThumbColor: inactiveThumbColor,
        inactiveTrackColor: inactiveTrackColor,
      ),
    );

    return isDisabled
        ? Tooltip(
          message: tooltipMessage,
          preferBelow: false,
          child: switchWidget,
        )
        : switchWidget;
  }
}
