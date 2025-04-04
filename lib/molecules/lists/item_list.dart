import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFItemListData {
  final String label;
  final IconData? icon;

  SFItemListData({required this.label, this.icon});
}

class SFItemList extends StatelessWidget {
  final List<SFItemListData> items;
  final ComponentSize size;
  final Color? iconColor;
  final IconData defaultIcon;

  const SFItemList({
    super.key,
    required this.items,
    this.size = ComponentSize.md,
    this.iconColor,
    this.defaultIcon = Icons.check_circle_outline_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children:
          items.map((item) {
            return SFItem(
              label: item.label,
              icon: item.icon ?? defaultIcon,
              size: size,
              iconColor: iconColor ?? Theme.of(context).primaryColor,
            );
          }).toList(),
    );
  }
}
