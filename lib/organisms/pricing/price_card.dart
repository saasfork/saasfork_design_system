import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:signals/signals_flutter.dart';

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

class SFPriceCard extends ConsumerStatefulWidget {
  final String title;
  final String? description;
  final SFPriceCardModel itemPrice;
  final String buttonLabel;
  final String? labelPopular;
  final List<String>? features;
  final Future Function()? onPressed;
  final String periodPrefix;
  final SFPriceCardModel? comparePrice;
  final String Function(String?)? savingsLabel;
  final String Function(SFPricePeriod?)? periodLabel;

  const SFPriceCard({
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
  });

  @override
  ConsumerState<SFPriceCard> createState() => _SFPriceCardState();
}

class _SFPriceCardState extends ConsumerState<SFPriceCard> with SignalsMixin {
  // Constantes pour la formatation des prix
  static const _decimalPlaces = 2;
  static const _decimalSuffix = '.00';
  static const _defaultZeroAmount = "0.00";
  static const _priceDivisor = 100.0;

  late final _isLoading = createSignal(false);

  String? _savingsPercentage;

  @override
  void initState() {
    super.initState();
    _savingsPercentage = _calculateSavingsPercentage();
  }

  String? _calculateSavingsPercentage() {
    if (widget.comparePrice == null) return null;

    final double regularAmount = widget.comparePrice!.unitAmount / 100;
    final double currentAmount = widget.itemPrice.unitAmount / 100;

    double effectiveRegular = regularAmount;
    double effectiveCurrent = currentAmount;

    // Cas spécial : on compare un prix mensuel à un prix annuel
    if (widget.comparePrice!.pricePeriod == SFPricePeriod.month &&
        widget.itemPrice.pricePeriod == SFPricePeriod.year) {
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

  String _getFormattedPrice() {
    if (widget.itemPrice.unitAmount <= 0) {
      return _defaultZeroAmount;
    }

    // Arrondir au centième
    final String formattedAmount = (widget.itemPrice.unitAmount / _priceDivisor)
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
    if (widget.itemPrice.currency.symbolBeforeValue) {
      return "${widget.itemPrice.currency.symbol}$cleanAmount";
    } else {
      return "$cleanAmount${widget.itemPrice.currency.symbol}";
    }
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: AppTypography.displaySmall.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    if (widget.comparePrice != null &&
                        widget.savingsLabel != null)
                      Container(
                        padding: AppSizes.getPadding(ComponentSize.xs),
                        decoration: BoxDecoration(
                          color: AppColors.green.s500.withValues(alpha: .2),
                          borderRadius: BorderRadius.circular(AppSpacing.md),
                        ),
                        child: Text(
                          savingsPercentage != null
                              ? widget.savingsLabel!(savingsPercentage)
                              : widget.savingsLabel!(null),
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.green.s800,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                if (widget.labelPopular != null)
                  Container(
                    padding: AppSizes.getPadding(ComponentSize.sm),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(AppSpacing.md),
                    ),
                    child: Text(
                      widget.labelPopular!,
                      style: AppTypography.labelSmall.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            if (widget.description != null)
              Text(widget.description!, style: AppTypography.bodyMedium),
            const SizedBox(height: AppSpacing.md),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _getFormattedPrice(),
                      style: AppTypography.displayLarge,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        '${widget.periodPrefix} ${widget.periodLabel != null ? widget.periodLabel!(widget.itemPrice.pricePeriod) : widget.itemPrice.pricePeriod.label}',
                        style: AppTypography.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            SFMainButton(
              label: widget.buttonLabel,
              onPressed: () async {
                if (widget.onPressed != null) {
                  _isLoading.value = true;
                  await widget.onPressed!();
                  _isLoading.value = false;
                }
              },
              disabled: widget.onPressed == null || _isLoading.value,
            ),
            const SizedBox(height: AppSpacing.md),
            if (widget.features != null && widget.features!.isNotEmpty)
              SFItemList(
                items: [
                  ...widget.features!.map(
                    (feature) => SFItemListData(label: feature),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

/// Un widget skeleton pour SFPriceCard qui affiche une version pour Skeletonizer.
///
/// Ce widget est conçu pour être utilisé avec le package Skeletonizer.
/// Il reproduit la structure du SFPriceCard pour un rendu cohérent lors du chargement.
///
/// Exemple d'utilisation :
/// ```dart
/// Skeletonizer(
///   enabled: isLoading,
///   child: SFPriceCardSkeleton(
///     featuresCount: 4,
///   ),
/// )
/// ```
///
/// [featuresCount] Nombre de features à afficher dans le skeleton.
/// [hasDiscountBadge] Indique si le badge de réduction doit être affiché.
/// [hasPopularBadge] Indique si le badge "populaire" doit être affiché.
class SFPriceCardSkeleton extends StatelessWidget {
  final int featuresCount;
  final bool hasDiscountBadge;
  final bool hasPopularBadge;

  const SFPriceCardSkeleton({
    this.featuresCount = 3,
    this.hasDiscountBadge = false,
    this.hasPopularBadge = false,
    super.key,
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Subscription Plan',
                      style: AppTypography.displaySmall.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    if (hasDiscountBadge)
                      Container(
                        padding: AppSizes.getPadding(ComponentSize.xs),
                        decoration: BoxDecoration(
                          color: AppColors.green.s500.withValues(alpha: .2),
                          borderRadius: BorderRadius.circular(AppSpacing.md),
                        ),
                        child: Text(
                          'Save 20%',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.green.s800,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                if (hasPopularBadge)
                  Container(
                    padding: AppSizes.getPadding(ComponentSize.sm),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(AppSpacing.md),
                    ),
                    child: Text(
                      'Popular',
                      style: AppTypography.labelSmall.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Subscription plan description with all features included.',
              style: AppTypography.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('€19.99', style: AppTypography.displayLarge),
                    const SizedBox(width: AppSpacing.xs),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text('/ month', style: AppTypography.bodyMedium),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            SFMainButton(label: 'Subscribe Now', onPressed: () {}),
            const SizedBox(height: AppSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                featuresCount,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          'Feature ${index + 1}',
                          style: AppTypography.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
