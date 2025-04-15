import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFPriceCardModel {
  final int unitAmount;
  final SFCurrency currency;
  final SFPricePeriod pricePeriod; // Enum pour la logique de calcul

  const SFPriceCardModel({
    required this.unitAmount,
    required this.currency,
    required this.pricePeriod,
  });
}

class SFPriceCard extends StatelessWidget {
  final String title;
  final String? description;
  final SFPriceCardModel itemPrice;
  final String buttonLabel;
  final String? labelPopular;
  final List<String>? features;
  final VoidCallback? onPressed;
  final String periodPrefix;
  final SFPriceCardModel? comparePrice;
  final String Function(String?)? savingsLabel;
  final String Function(SFPricePeriod?)? periodLabel;
  final String? _savingsPercentage;

  // Constantes pour la formatation des prix
  static const _decimalPlaces = 2;
  static const _decimalSuffix = '.00';
  static const _defaultZeroAmount = "0.00";
  static const _priceDivisor = 100.0;

  SFPriceCard({
    super.key,
    required this.title,
    required this.itemPrice,
    this.onPressed,
    required this.buttonLabel,
    this.features,
    this.description,
    this.labelPopular,
    this.periodPrefix = '/',
    this.comparePrice,
    this.savingsLabel,
    this.periodLabel,
  }) : _savingsPercentage = _calculateSavingsPercentageStatic(
         comparePrice,
         itemPrice,
       );

  String _getFormattedPrice() {
    if (itemPrice.unitAmount <= 0) {
      return _defaultZeroAmount;
    }

    // Arrondir au centième
    final String formattedAmount = (itemPrice.unitAmount / _priceDivisor)
        .toStringAsFixed(_decimalPlaces);

    // Supprimer les zéros inutiles après la virgule si montant entier
    final String cleanAmount =
        formattedAmount.endsWith(_decimalSuffix)
            ? formattedAmount.substring(
              0,
              formattedAmount.length - _decimalSuffix.length,
            )
            : formattedAmount;

    // Positionner la devise selon sa configuration
    if (itemPrice.currency.symbolBeforeValue) {
      return "${itemPrice.currency.symbol}$cleanAmount";
    } else {
      return "$cleanAmount${itemPrice.currency.symbol}";
    }
  }

  static String? _calculateSavingsPercentageStatic(
    SFPriceCardModel? comparePrice,
    SFPriceCardModel itemPrice,
  ) {
    if (comparePrice == null) return null;

    final double regularAmount = comparePrice.unitAmount / 100;
    final double currentAmount = itemPrice.unitAmount / 100;

    double effectiveRegular = regularAmount;
    double effectiveCurrent = currentAmount;

    // Cas spécial : on compare un prix mensuel à un prix annuel
    if (comparePrice.pricePeriod == SFPricePeriod.month &&
        itemPrice.pricePeriod == SFPricePeriod.year) {
      effectiveRegular = regularAmount * 12;
    }

    if (effectiveRegular > effectiveCurrent) {
      final int savings =
          ((effectiveRegular - effectiveCurrent) / effectiveRegular * 100)
              .round();
      return "${savings.clamp(0, 100)}";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final savingsPercentage = _savingsPercentage;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: AppSpacing.sm,
                  children: [
                    Text(
                      title,
                      style: AppTypography.displaySmall.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    if (comparePrice != null && savingsLabel != null)
                      Container(
                        padding: AppSizes.getPadding(ComponentSize.xs),
                        decoration: BoxDecoration(
                          color: AppColors.green.s500.withValues(alpha: .2),
                          borderRadius: BorderRadius.circular(AppSpacing.md),
                        ),
                        child: Text(
                          savingsPercentage != null
                              ? savingsLabel!(savingsPercentage)
                              : savingsLabel!(null),
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.green.s800,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                if (labelPopular != null)
                  Container(
                    padding: AppSizes.getPadding(ComponentSize.sm),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(AppSpacing.md),
                    ),
                    child: Text(
                      labelPopular!,
                      style: AppTypography.labelSmall.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
              ],
            ),
            if (description != null)
              Text(description!, style: AppTypography.bodyMedium),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: AppSpacing.xs,
                  children: [
                    Text(
                      _getFormattedPrice(),
                      style: AppTypography.displayLarge,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Text(
                        '$periodPrefix ${periodLabel != null ? periodLabel!(itemPrice.pricePeriod) : itemPrice.pricePeriod.label}',
                        style: AppTypography.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SFMainButton(
              label: buttonLabel,
              onPressed: onPressed,
              disabled: onPressed == null,
            ),
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
