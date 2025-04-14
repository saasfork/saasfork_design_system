import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

void main() {
  group('SFPriceCard', () {
    testWidgets('afficher correctement les éléments de base', (
      WidgetTester tester,
    ) async {
      // ARRANGE
      // ACT
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFPriceCard(
              title: 'Basique',
              price: '10€',
              period: 'mois',
              buttonLabel: 'Souscrire',
              onPressed: () {},
            ),
          ),
        ),
      );

      // ASSERT
      expect(find.text('Basique'), findsOneWidget);
      expect(find.text('10€'), findsOneWidget);
      expect(find.text('/mois'), findsOneWidget);
      expect(find.text('Souscrire'), findsOneWidget);
    });

    testWidgets('afficher correctement la description quand elle est fournie', (
      WidgetTester tester,
    ) async {
      // ARRANGE
      const description = 'Forfait idéal pour démarrer';

      // ACT
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFPriceCard(
              title: 'Basique',
              price: '10€',
              period: 'mois',
              buttonLabel: 'Souscrire',
              description: description,
              onPressed: () {},
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

      // ACT
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFPriceCard(
              title: 'Basique',
              price: '10€',
              period: 'mois',
              buttonLabel: 'Souscrire',
              onPressed: () {},
            ),
          ),
        ),
      );

      // ASSERT
      expect(find.text(description), findsNothing);
    });

    testWidgets(
      'afficher correctement le label populaire quand isPopular est true',
      (WidgetTester tester) async {
        // ARRANGE
        const labelText = 'Populaire';

        // ACT
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SFPriceCard(
                title: 'Standard',
                price: '29€',
                period: 'mois',
                buttonLabel: 'Souscrire',
                isPopular: true,
                label: labelText,
                onPressed: () {},
              ),
            ),
          ),
        );

        // ASSERT
        expect(find.text(labelText), findsOneWidget);
      },
    );

    testWidgets(
      'ne pas afficher le label populaire quand isPopular est false',
      (WidgetTester tester) async {
        // ARRANGE
        const labelText = 'Populaire';

        // ACT
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SFPriceCard(
                title: 'Standard',
                price: '29€',
                period: 'mois',
                buttonLabel: 'Souscrire',
                isPopular: false,
                label: labelText,
                onPressed: () {},
              ),
            ),
          ),
        );

        // ASSERT
        expect(find.text(labelText), findsNothing);
      },
    );

    testWidgets(
      'afficher correctement les fonctionnalités quand elles sont fournies',
      (WidgetTester tester) async {
        // ARRANGE
        final features = [
          '10GB de stockage',
          'Support email',
          'Accès à toutes les fonctionnalités',
        ];

        // ACT
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SFPriceCard(
                title: 'Premium',
                price: '49€',
                period: 'mois',
                buttonLabel: 'Souscrire',
                features: features,
                onPressed: () {},
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
        // ARRANGE - Création d'une liste vide pour tester l'absence d'items

        // ACT
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SFPriceCard(
                title: 'Basique',
                price: '10€',
                period: 'mois',
                buttonLabel: 'Souscrire',
                onPressed: () {},
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

        // ACT
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SFPriceCard(
                title: 'Basique',
                price: '10€',
                period: 'mois',
                buttonLabel: 'Souscrire',
                onPressed: () => buttonPressed = true,
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
  });
}
