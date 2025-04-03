/// Enumération des périodes de tarification possibles
enum SFPricePeriod {
  day,
  week,
  month,
  year,
  lifetime;

  /// Retourne la représentation textuelle de la période
  String get label {
    switch (this) {
      case SFPricePeriod.day:
        return 'day';
      case SFPricePeriod.week:
        return 'week';
      case SFPricePeriod.month:
        return 'month';
      case SFPricePeriod.year:
        return 'year';
      case SFPricePeriod.lifetime:
        return 'once';
    }
  }
}
