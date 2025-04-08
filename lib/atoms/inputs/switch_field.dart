import 'package:flutter/material.dart';

class SFSwitchField extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SFSwitchField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(value: value, onChanged: onChanged);
  }
}
