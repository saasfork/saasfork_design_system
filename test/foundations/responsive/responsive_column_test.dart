import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/foundations/responsive/responsive_column.dart';
import 'package:saasfork_design_system/foundations/responsive/responsive_row.dart';

void main() {
  group('SFResponsiveColumn', () {
    testWidgets('devrait adapter sa taille basé sur xs en mode mobile', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(320, 568)), // Taille mobile
            child: SFResponsiveColumn(
              xs: 6,
              child: const SizedBox(height: 100),
            ),
          ),
        ),
      );

      // Vérifier que la colonne utilise 6/12 de l'écran en mode mobile
      final fractionallySizedBox = tester.widget<FractionallySizedBox>(
        find.byType(FractionallySizedBox),
      );
      expect(fractionallySizedBox.widthFactor, 0.5); // 6/12
    });

    testWidgets('devrait adapter sa taille basé sur sm en mode tablette', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(
              size: Size(800, 1024),
            ), // Taille tablette
            child: SFResponsiveColumn(
              xs: 12,
              sm: 6,
              child: const SizedBox(height: 100),
            ),
          ),
        ),
      );

      // Vérifier que la colonne utilise 6/12 de l'écran en mode tablette
      final fractionallySizedBox = tester.widget<FractionallySizedBox>(
        find.byType(FractionallySizedBox),
      );
      expect(fractionallySizedBox.widthFactor, 0.5); // 6/12
    });

    testWidgets('devrait adapter sa taille basé sur md en mode desktop', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)), // Taille desktop
            child: SFResponsiveColumn(
              xs: 12,
              sm: 8,
              md: 4,
              child: const SizedBox(height: 100),
            ),
          ),
        ),
      );

      // Vérifier que la colonne utilise 4/12 de l'écran en mode desktop
      final fractionallySizedBox = tester.widget<FractionallySizedBox>(
        find.byType(FractionallySizedBox),
      );
      expect(fractionallySizedBox.widthFactor, closeTo(1 / 3, 0.01)); // 4/12
    });

    testWidgets('devrait adapter sa taille basé sur lg en grand écran', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1600, 900)), // Grand écran
            child: SFResponsiveColumn(
              xs: 12,
              sm: 8,
              md: 6,
              lg: 3,
              child: const SizedBox(height: 100),
            ),
          ),
        ),
      );

      // Vérifier que la colonne utilise 3/12 de l'écran en mode grand écran
      final fractionallySizedBox = tester.widget<FractionallySizedBox>(
        find.byType(FractionallySizedBox),
      );
      expect(fractionallySizedBox.widthFactor, 0.25); // 3/12
    });

    testWidgets(
      'devrait utiliser la valeur du breakpoint précédent si non définie',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(1600, 900)), // Grand écran
              child: SFResponsiveColumn(
                xs: 6,
                // sm, md et lg non définis, devrait utiliser xs
                child: const SizedBox(height: 100),
              ),
            ),
          ),
        );

        // Vérifier que la colonne utilise 6/12 de l'écran en grand écran (fallback à xs)
        final fractionallySizedBox = tester.widget<FractionallySizedBox>(
          find.byType(FractionallySizedBox),
        );
        expect(fractionallySizedBox.widthFactor, 0.5); // 6/12
      },
    );

    testWidgets(
      'devrait utiliser un Flexible quand il est enfant direct d\'un Row',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SFResponsiveRow(
                children: [
                  SFResponsiveColumn(xs: 6, child: const SizedBox(height: 100)),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(Flexible), findsOneWidget);
        expect(find.byType(FractionallySizedBox), findsNothing);

        final flexible = tester.widget<Flexible>(find.byType(Flexible));
        expect(flexible.flex, 6);
      },
    );

    testWidgets('devrait appliquer le padding correctement', (
      WidgetTester tester,
    ) async {
      const testPadding = EdgeInsets.all(16.0);

      await tester.pumpWidget(
        MaterialApp(
          home: SFResponsiveColumn(
            xs: 12,
            padding: testPadding,
            child: const SizedBox(height: 100),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.padding, equals(testPadding));
    });

    testWidgets('devrait appliquer la decoration correctement', (
      WidgetTester tester,
    ) async {
      final testDecoration = BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(8.0),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: SFResponsiveColumn(
            xs: 12,
            decoration: testDecoration,
            child: const SizedBox(height: 100),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.decoration, equals(testDecoration));
    });

    testWidgets('devrait appliquer l\'alignment correctement', (
      WidgetTester tester,
    ) async {
      const testAlignment = Alignment.center;

      await tester.pumpWidget(
        MaterialApp(
          home: SFResponsiveColumn(
            xs: 12,
            alignment: testAlignment,
            child: const SizedBox(height: 100),
          ),
        ),
      );

      expect(find.byType(Align), findsOneWidget);
      final align = tester.widget<Align>(find.byType(Align));
      expect(align.alignment, equals(testAlignment));
    });

    testWidgets(
      'devrait utiliser la largeur totale si aucun span n\'est défini',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: SFResponsiveColumn(
              // Aucun xs, sm, md, lg défini
              child: const SizedBox(height: 100),
            ),
          ),
        );

        final fractionallySizedBox = tester.widget<FractionallySizedBox>(
          find.byType(FractionallySizedBox),
        );
        expect(fractionallySizedBox.widthFactor, 1.0); // Largeur totale (12/12)
      },
    );
  });
}
