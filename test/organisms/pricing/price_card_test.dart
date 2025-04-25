import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

void main() {
  group('SFPriceCard', () {
    testWidgets('afficher correctement les éléments de base', (
      WidgetTester tester,
    ) async {
      // ARRANGE
      final priceModel = SFPriceCardModel(
        unitAmount: 1000, // 10.00 €
        currency: SFCurrency.eur,
        pricePeriod: SFPricePeriod.month,
      );

      // ACT
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFPriceCard(
              title: 'Basique',
              itemPrice: priceModel,
              buttonLabel: 'Souscrire',
              onPressed: () async {},
            ),
          ),
        ),
      );

      // ASSERT
      expect(find.text('Basique'), findsOneWidget);
      expect(find.text('10€'), findsOneWidget);
      expect(find.text('/ month'), findsOneWidget);
      expect(find.text('Souscrire'), findsOneWidget);
    });

    testWidgets('afficher correctement la description quand elle est fournie', (
      WidgetTester tester,
    ) async {
      // ARRANGE
      const description = 'Forfait idéal pour démarrer';
      final priceModel = SFPriceCardModel(
        unitAmount: 1000,
        currency: SFCurrency.eur,
        pricePeriod: SFPricePeriod.month,
      );

      // ACT
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFPriceCard(
              title: 'Basique',
              itemPrice: priceModel,
              buttonLabel: 'Souscrire',
              description: description,
              onPressed: () async {},
            ),
          ),
        ),
      );

      // ASSERT
      expect(find.text(description), findsOneWidget);
    });

    testWidgets('ne pas afficher la description quand elle est absente', (
      WidgetTester tester,
    ) async {
      // ARRANGE
      const description = 'Forfait idéal pour démarrer';
      final priceModel = SFPriceCardModel(
        unitAmount: 1000,
        currency: SFCurrency.eur,
        pricePeriod: SFPricePeriod.month,
      );

      // ACT
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFPriceCard(
              title: 'Basique',
              itemPrice: priceModel,
              buttonLabel: 'Souscrire',
              onPressed: () async {},
            ),
          ),
        ),
      );

      // ASSERT
      expect(find.text(description), findsNothing);
    });

    testWidgets(
      'afficher correctement le label populaire quand il est fourni',
      (WidgetTester tester) async {
        // ARRANGE
        const labelText = 'Populaire';
        final priceModel = SFPriceCardModel(
          unitAmount: 2900,
          currency: SFCurrency.eur,
          pricePeriod: SFPricePeriod.month,
        );

        // ACT
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SFPriceCard(
                title: 'Standard',
                itemPrice: priceModel,
                buttonLabel: 'Souscrire',
                labelPopular: labelText,
                onPressed: () async {},
              ),
            ),
          ),
        );

        // ASSERT
        expect(find.text(labelText), findsOneWidget);
      },
    );

    testWidgets('ne pas afficher le label populaire quand il est absent', (
      WidgetTester tester,
    ) async {
      // ARRANGE
      const labelText = 'Populaire';
      final priceModel = SFPriceCardModel(
        unitAmount: 2900,
        currency: SFCurrency.eur,
        pricePeriod: SFPricePeriod.month,
      );

      // ACT
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFPriceCard(
              title: 'Standard',
              itemPrice: priceModel,
              buttonLabel: 'Souscrire',
              onPressed: () async {},
            ),
          ),
        ),
      );

      // ASSERT
      expect(find.text(labelText), findsNothing);
    });

    testWidgets(
      'afficher correctement les fonctionnalités quand elles sont fournies',
      (WidgetTester tester) async {
        // ARRANGE
        final features = [
          '10GB de stockage',
          'Support email',
          'Accès à toutes les fonctionnalités',
        ];
        final priceModel = SFPriceCardModel(
          unitAmount: 4900,
          currency: SFCurrency.eur,
          pricePeriod: SFPricePeriod.month,
        );

        // ACT
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SFPriceCard(
                title: 'Premium',
                itemPrice: priceModel,
                buttonLabel: 'Souscrire',
                features: features,
                onPressed: () async {},
              ),
            ),
          ),
        );

        // ASSERT
        for (final feature in features) {
          expect(find.text(feature), findsOneWidget);
        }
      },
    );

    testWidgets(
      'ne pas afficher la section fonctionnalités quand elle est absente',
      (WidgetTester tester) async {
        // ARRANGE
        final priceModel = SFPriceCardModel(
          unitAmount: 1000,
          currency: SFCurrency.eur,
          pricePeriod: SFPricePeriod.month,
        );

        // ACT
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SFPriceCard(
                title: 'Basique',
                itemPrice: priceModel,
                buttonLabel: 'Souscrire',
                onPressed: () async {},
                features: [], // Liste vide de fonctionnalités
              ),
            ),
          ),
        );

        // ASSERT - Vérifions que SFItemList n'est pas rendu
        expect(find.byType(SFItemList), findsNothing);
      },
    );

    testWidgets(
      'déclencher la fonction onPressed quand on clique sur le bouton',
      (WidgetTester tester) async {
        // ARRANGE
        bool buttonPressed = false;
        final priceModel = SFPriceCardModel(
          unitAmount: 1000,
          currency: SFCurrency.eur,
          pricePeriod: SFPricePeriod.month,
        );

        // ACT
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SFPriceCard(
                title: 'Basique',
                itemPrice: priceModel,
                buttonLabel: 'Souscrire',
                onPressed: () async => buttonPressed = true,
              ),
            ),
          ),
        );

        // Trouver et appuyer sur le bouton
        await tester.tap(find.byType(SFMainButton));
        await tester.pump();

        // ASSERT
        expect(buttonPressed, isTrue);
      },
    );

    testWidgets(
      'afficher correctement les économies lorsque comparePrice est fourni',
      (WidgetTester tester) async {
        // ARRANGE
        final itemPrice = SFPriceCardModel(
          unitAmount: 20000, // 200€
          currency: SFCurrency.eur,
          pricePeriod: SFPricePeriod.year,
        );

        final comparePrice = SFPriceCardModel(
          unitAmount: 2000, // 20€
          currency: SFCurrency.eur,
          pricePeriod: SFPricePeriod.month,
        );

        // ACT
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SFPriceCard(
                title: 'Annuel',
                itemPrice: itemPrice,
                buttonLabel: 'Souscrire',
                onPressed: () async {},
                comparePrice: comparePrice,
                savingsLabel: (percentage) => 'Économisez $percentage%',
              ),
            ),
          ),
        );

        // ASSERT
        expect(find.text('Économisez 17%'), findsOneWidget);
      },
    );

    testWidgets('utiliser le periodLabel personnalisé quand il est fourni', (
      WidgetTester tester,
    ) async {
      // ARRANGE
      final priceModel = SFPriceCardModel(
        unitAmount: 1000,
        currency: SFCurrency.eur,
        pricePeriod: SFPricePeriod.month,
      );

      // ACT
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFPriceCard(
              title: 'Basique',
              itemPrice: priceModel,
              buttonLabel: 'Souscrire',
              onPressed: () async {},
              periodLabel: (period) => 'par mois',
            ),
          ),
        ),
      );

      // ASSERT
      expect(find.text('/ par mois'), findsOneWidget);
    });
  });
}
