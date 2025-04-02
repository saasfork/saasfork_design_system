/// Énumération des devises supportées par l'application
enum SFCurrency {
  eur,
  usd,
  gbp,
  jpy,
  cad,
  aud,
  chf;

  /// Retourne le symbole de la devise
  String get symbol {
    switch (this) {
      case SFCurrency.eur:
        return '€';
      case SFCurrency.usd:
        return '\$';
      case SFCurrency.gbp:
        return '£';
      case SFCurrency.jpy:
        return '¥';
      case SFCurrency.cad:
        return 'CA\$';
      case SFCurrency.aud:
        return 'A\$';
      case SFCurrency.chf:
        return 'CHF';
    }
  }

  /// Retourne le code ISO de la devise
  String get code {
    switch (this) {
      case SFCurrency.eur:
        return 'EUR';
      case SFCurrency.usd:
        return 'USD';
      case SFCurrency.gbp:
        return 'GBP';
      case SFCurrency.jpy:
        return 'JPY';
      case SFCurrency.cad:
        return 'CAD';
      case SFCurrency.aud:
        return 'AUD';
      case SFCurrency.chf:
        return 'CHF';
    }
  }

  /// Retourne si le symbole est placé avant ou après le montant
  bool get symbolBeforeValue {
    switch (this) {
      case SFCurrency.eur:
        return false; // En français, l'euro est après (ex: 10 €)
      case SFCurrency.jpy:
        return true;
      case SFCurrency.chf:
        return false; // En français, le CHF est après (ex: 10 CHF)
      default:
        return true; // La plupart des devises sont avant (ex: $10)
    }
  }

  /// Retourne le séparateur décimal (point ou virgule)
  String get decimalSeparator {
    switch (this) {
      case SFCurrency.eur:
        return ','; // En français, on utilise la virgule
      case SFCurrency.gbp:
      case SFCurrency.chf:
        return '.';
      case SFCurrency.usd:
      case SFCurrency.cad:
      case SFCurrency.aud:
      case SFCurrency.jpy:
        return '.';
    }
  }

  /// Retourne le nombre de décimales à afficher
  int get decimalPlaces {
    switch (this) {
      case SFCurrency.jpy:
        return 0; // Le yen n'utilise pas de décimales
      default:
        return 2;
    }
  }

  /// Retourne l'espacement entre le symbole et le montant
  double get symbolSpacing {
    switch (this) {
      case SFCurrency.eur:
      case SFCurrency.chf:
        return 4.0; // Espacement pour les devises après le montant
      default:
        return 1.0; // Peu ou pas d'espacement pour les devises avant le montant
    }
  }
}

/// Extension pour fournir des méthodes utilitaires de formatage
extension CurrencyFormatting on SFCurrency {
  /// Formatte un montant selon les règles de la devise
  String format(int valueInCents, {bool includeCurrencyCode = false}) {
    final double value = valueInCents / 100;
    final String formattedValue;

    if (decimalPlaces == 0) {
      formattedValue = value.round().toString();
    } else {
      formattedValue = value
          .toStringAsFixed(decimalPlaces)
          .replaceAll('.', decimalSeparator);
    }

    if (includeCurrencyCode) {
      return '$formattedValue $code';
    } else {
      if (symbolBeforeValue) {
        return '$symbol$formattedValue';
      } else {
        return '$formattedValue$symbol';
      }
    }
  }
}
