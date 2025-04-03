import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

void main() {
  group('SFPriceDefault', () {
    testWidgets('renders correctly with round value', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SFPriceDefault(
              value: 1000,
              currency: SFCurrency.eur,
              period: SFPricePeriod.month,
            ),
          ),
        ),
      );

      expect(find.text('10'), findsOneWidget);
      expect(find.text('€'), findsOneWidget);
      expect(find.text('/month'), findsOneWidget);
    });

    testWidgets('renders correctly with decimal value', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SFPriceDefault(
              value: 1099,
              currency: SFCurrency.eur,
              period: SFPricePeriod.month,
            ),
          ),
        ),
      );

      expect(find.text('10'), findsOneWidget);
      expect(find.text(',99'), findsOneWidget);
      expect(find.text('€'), findsOneWidget);
      expect(find.text('/month'), findsOneWidget);
    });

    testWidgets('handles USD currency correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SFPriceDefault(
              value: 1099,
              currency: SFCurrency.usd,
              period: SFPricePeriod.month,
            ),
          ),
        ),
      );

      expect(find.text('\$'), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
      expect(find.text('.99'), findsOneWidget);
    });

    testWidgets('handles JPY currency (no decimals) correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SFPriceDefault(
              value: 1099,
              currency: SFCurrency.jpy,
              period: SFPricePeriod.month,
            ),
          ),
        ),
      );

      expect(find.text('¥'), findsOneWidget);
      expect(find.text('11'), findsOneWidget);
      expect(find.text('.99'), findsNothing);
    });

    testWidgets('renders with different period types', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SFPriceDefault(
              value: 1000,
              currency: SFCurrency.eur,
              period: SFPricePeriod.year,
            ),
          ),
        ),
      );
      expect(find.text('/year'), findsOneWidget);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SFPriceDefault(
              value: 1000,
              currency: SFCurrency.eur,
              period: SFPricePeriod.lifetime,
            ),
          ),
        ),
      );
      expect(find.text('/once'), findsOneWidget);
    });

    testWidgets('renders with different sizes', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SFPriceDefault(
              value: 1000,
              currency: SFCurrency.eur,
              period: SFPricePeriod.month,
              size: ComponentSize.xs,
            ),
          ),
        ),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SFPriceDefault(
              value: 1000,
              currency: SFCurrency.eur,
              period: SFPricePeriod.month,
              size: ComponentSize.xl,
            ),
          ),
        ),
      );

      expect(find.text('10'), findsOneWidget);
    });

    testWidgets('hides period when showPeriod is false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SFPriceDefault(
              value: 1000,
              currency: SFCurrency.eur,
              period: SFPricePeriod.month,
              showPeriod: false,
            ),
          ),
        ),
      );

      expect(find.text('/month'), findsNothing);
    });

    testWidgets('uses currency code when useCurrencyCode is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SFPriceDefault(
              value: 1000,
              currency: SFCurrency.eur,
              period: SFPricePeriod.month,
              useCurrencyCode: true,
            ),
          ),
        ),
      );

      expect(find.text('€'), findsNothing);
      expect(find.text('EUR'), findsOneWidget);
    });

    test('SFPricePeriod.label returns correct value', () {
      expect(SFPricePeriod.day.label, equals('day'));
      expect(SFPricePeriod.week.label, equals('week'));
      expect(SFPricePeriod.month.label, equals('month'));
      expect(SFPricePeriod.year.label, equals('year'));
      expect(SFPricePeriod.lifetime.label, equals('once'));
    });
  });
}
