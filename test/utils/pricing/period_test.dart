import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/utils/pricing/period.dart';

void main() {
  group('convertFromLabel', () {
    test('devrait convertir des labels simples correctement', () {
      expect(convertFromLabel('day'), equals(SFPricePeriod.day));
      expect(convertFromLabel('week'), equals(SFPricePeriod.week));
      expect(convertFromLabel('month'), equals(SFPricePeriod.month));
      expect(convertFromLabel('year'), equals(SFPricePeriod.year));
      expect(convertFromLabel('once'), equals(SFPricePeriod.lifetime));
    });

    test('devrait extraire le label après un point', () {
      expect(convertFromLabel('price.day'), equals(SFPricePeriod.day));
      expect(convertFromLabel('price.week'), equals(SFPricePeriod.week));
      expect(
        convertFromLabel('subscription.month'),
        equals(SFPricePeriod.month),
      );
      expect(convertFromLabel('plan.year'), equals(SFPricePeriod.year));
      expect(convertFromLabel('payment.once'), equals(SFPricePeriod.lifetime));
    });

    test(
      'devrait retourner SFPricePeriod.month pour des valeurs invalides',
      () {
        expect(convertFromLabel('invalid'), equals(SFPricePeriod.month));
        expect(convertFromLabel(''), equals(SFPricePeriod.month));
        expect(convertFromLabel('price.invalid'), equals(SFPricePeriod.month));
      },
    );
  });
}
