import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final ComponentSize size;
  final Color? iconColor;

  const SFItem({
    super.key,
    required this.label,
    required this.icon,
    this.size = ComponentSize.md,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.all(0.0),
      leading: Icon(
        icon,
        size: AppSizes.getIconSize(size),
        color: iconColor ?? Theme.of(context).primaryColor,
      ),
      title: Text(
        label,
        style: AppTypography.getScaledStyle(AppTypography.labelLarge, size),
      ),
    );
  }
}
