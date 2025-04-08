import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFFooterSection extends StatelessWidget {
  final bool showCopyright;
  final String companyName;
  final int year;
  final bool showAllRightsReserved;

  const SFFooterSection({
    super.key,
    this.showCopyright = true,
    this.companyName = 'Your Company, Inc.',
    this.year = 2024,
    this.showAllRightsReserved = true,
  });

  @override
  Widget build(BuildContext context) {
    List<String> content = [];

    if (showCopyright) {
      content.add('©');
    }

    if (year > 0) {
      content.add(year.toString());
    }

    if (companyName.isNotEmpty) {
      content.add(companyName);
    }

    if (showAllRightsReserved) {
      content.add('All rights reserved.');
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            content.join(' '),
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
