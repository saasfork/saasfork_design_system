/// Enumération des périodes de tarification possibles
enum SFPricePeriod {
  daily,
  weekly,
  monthly,
  quarterly,
  yearly,
  lifetime;

  /// Retourne la représentation textuelle de la période
  String get label {
    switch (this) {
      case SFPricePeriod.daily:
        return 'day';
      case SFPricePeriod.weekly:
        return 'week';
      case SFPricePeriod.monthly:
        return 'month';
      case SFPricePeriod.quarterly:
        return 'quarter';
      case SFPricePeriod.yearly:
        return 'year';
      case SFPricePeriod.lifetime:
        return 'once';
    }
  }
}
