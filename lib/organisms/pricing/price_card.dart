import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFPriceCard extends StatelessWidget {
  final String title;
  final String? description;
  final String price;
  final String period;
  final String buttonLabel;
  final String? label;
  final List<String>? features;
  final VoidCallback onPressed;
  final bool isPopular;
  final String periodPrefix;

  const SFPriceCard({
    super.key,
    required this.title,
    required this.price,
    required this.period,
    required this.onPressed,
    required this.buttonLabel,
    this.isPopular = false,
    this.features,
    this.description,
    this.label,
    this.periodPrefix = '/',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        side: BorderSide(color: Theme.of(context).primaryColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.md,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTypography.displaySmall.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                if (isPopular && label != null)
                  Container(
                    padding: AppSizes.getPadding(ComponentSize.sm),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(AppSpacing.md),
                    ),
                    child: Text(
                      label!,
                      style: AppTypography.labelSmall.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
              ],
            ),
            if (description != null)
              Text(description!, style: AppTypography.bodyMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: AppSpacing.xs,
              children: [
                Text(price, style: AppTypography.displayLarge),
                Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Text(
                    '$periodPrefix$period',
                    style: AppTypography.bodyMedium,
                  ),
                ),
              ],
            ),
            SFMainButton(label: buttonLabel, onPressed: onPressed),
            if (features != null && features!.isNotEmpty)
              SFItemList(
                items: [
                  ...features!.map((feature) => SFItemListData(label: feature)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
