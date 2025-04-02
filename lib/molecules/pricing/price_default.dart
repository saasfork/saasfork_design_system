import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

/// Composant affichant un prix avec devise et période
class SFPriceDefault extends StatelessWidget {
  /// Valeur en centimes (ex: 999 pour 9,99€)
  final int value;

  /// Devise du prix
  final SFCurrency currency;

  /// Période de facturation
  final SFPricePeriod period;

  /// Taille du composant
  final ComponentSize size;

  /// Indique si la période doit être affichée
  final bool showPeriod;

  /// Indique si le code de la devise doit être utilisé au lieu du symbole
  final bool useCurrencyCode;

  const SFPriceDefault({
    required this.value,
    required this.currency,
    required this.period,
    this.size = ComponentSize.md,
    this.showPeriod = true,
    this.useCurrencyCode = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Conversion et formatage optimisés
    final double monetaryValue = value / 100;
    final bool isWholeNumber =
        monetaryValue == monetaryValue.truncateToDouble();

    // Formatage optimisé pour éviter les splits inutiles
    final String formattedValue =
        isWholeNumber
            ? monetaryValue.toInt().toString()
            : monetaryValue.toStringAsFixed(currency.decimalPlaces);

    // Utiliser indexOf pour trouver le séparateur décimal si présent
    final int separatorIndex = formattedValue.indexOf('.');
    final String wholePart =
        separatorIndex >= 0
            ? formattedValue.substring(0, separatorIndex)
            : formattedValue;

    final String decimalPart =
        (separatorIndex >= 0 && !isWholeNumber && currency.decimalPlaces > 0)
            ? formattedValue.substring(separatorIndex + 1)
            : '';

    // Créer les composants du prix
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: _buildPriceComponents(
        wholePart: wholePart,
        decimalPart: decimalPart,
      ),
    );
  }

  /// Construit les composants du prix dans le bon ordre selon la devise
  List<Widget> _buildPriceComponents({
    required String wholePart,
    required String decimalPart,
  }) {
    // Récupérer les styles une seule fois
    final wholeStyle = _getWholePartStyle();
    final decimalStyle = _getDecimalPartStyle();
    final periodStyle = _getPeriodStyle();

    final String currencyText =
        useCurrencyCode ? currency.code : currency.symbol;
    final Widget currencyWidget = Text(currencyText, style: wholeStyle);

    // Construction concise avec spread operator
    return [
      if (currency.symbolBeforeValue && !useCurrencyCode) ...[
        currencyWidget,
        const SizedBox(width: 1),
      ],
      Text(wholePart, style: wholeStyle),
      if (decimalPart.isNotEmpty)
        Text('${currency.decimalSeparator}$decimalPart', style: decimalStyle),
      if (!currency.symbolBeforeValue || useCurrencyCode) ...[
        SizedBox(width: currency.symbolSpacing),
        currencyWidget,
      ],
      if (showPeriod) ...[
        const SizedBox(width: AppSpacing.xs),
        Text('/${period.label}', style: periodStyle),
      ],
    ];
  }

  // Cache statique des styles pour éviter les recréations
  static final Map<ComponentSize, TextStyle> _wholePartStyles = {
    ComponentSize.xs: AppTypography.headlineMedium.copyWith(
      fontWeight: FontWeight.bold,
    ),
    ComponentSize.sm: AppTypography.headlineLarge.copyWith(
      fontWeight: FontWeight.bold,
    ),
    ComponentSize.md: AppTypography.displaySmall.copyWith(
      fontWeight: FontWeight.bold,
    ),
    ComponentSize.lg: AppTypography.displayMedium.copyWith(
      fontWeight: FontWeight.bold,
    ),
    ComponentSize.xl: AppTypography.displayLarge.copyWith(
      fontWeight: FontWeight.bold,
    ),
  };

  TextStyle _getWholePartStyle() => _wholePartStyles[size]!;

  // Style de la partie décimale
  TextStyle _getDecimalPartStyle() {
    // Construction basée sur la taille
    switch (size) {
      case ComponentSize.xs:
        return AppTypography.titleMedium.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: AppTypography.titleMedium.fontSize! * 0.8,
        );
      case ComponentSize.sm:
        return AppTypography.titleLarge.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: AppTypography.titleLarge.fontSize! * 0.8,
        );
      case ComponentSize.md:
        return AppTypography.headlineSmall.copyWith(
          fontWeight: FontWeight.bold,
        );
      case ComponentSize.lg:
        return AppTypography.headlineMedium.copyWith(
          fontWeight: FontWeight.bold,
        );
      case ComponentSize.xl:
        return AppTypography.headlineLarge.copyWith(
          fontWeight: FontWeight.bold,
        );
    }
  }

  // Style du texte de période
  TextStyle _getPeriodStyle() {
    final baseStyle = switch (size) {
      ComponentSize.xs => AppTypography.bodySmall,
      ComponentSize.sm => AppTypography.bodyMedium,
      ComponentSize.md => AppTypography.bodyLarge,
      ComponentSize.lg => AppTypography.titleSmall,
      ComponentSize.xl => AppTypography.titleMedium,
    };

    return baseStyle.copyWith(
      color: AppColors.grey.s500,
      fontWeight: FontWeight.normal,
    );
  }
}
