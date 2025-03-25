import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/foundations/responsive/responsive_grid.dart';

void main() {
  group('SFResponsiveGrid', () {
    testWidgets('crée une grille avec le nombre correct d\'enfants', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SFResponsiveGrid(
            children: List.generate(
              4,
              (index) => Container(
                height: 50,
                color: Colors.blue,
                child: Center(child: Text('Item $index')),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
    });

    testWidgets('utilise les colonnes personnalisées sur mobile', (
      tester,
    ) async {
      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(size: const Size(320, 600)),
          child: MaterialApp(
            home: SFResponsiveGrid(
              mobileColumns: 2, // Forcer 2 colonnes sur mobile
              spacing: 10,
              children: List.generate(
                4,
                (index) => Container(
                  height: 50,
                  color: Colors.blue,
                  child: Center(child: Text('Item $index')),
                ),
              ),
            ),
          ),
        ),
      );

      // Vérifier que Wrap est utilisé comme conteneur principal
      final wrapFinder = find.byType(Wrap);
      expect(wrapFinder, findsOneWidget);

      // Vérifier que les SizedBox sont correctement dimensionnés
      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox));
      expect(sizedBoxes.length, 4);

      // Vérifier la présence de tous les items
      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
    });

    testWidgets('applique margin et padding correctement', (tester) async {
      const margin = EdgeInsets.all(15.0);
      const padding = EdgeInsets.all(10.0);

      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(size: const Size(800, 600)),
          child: MaterialApp(
            home: SFResponsiveGrid(
              margin: margin,
              padding: padding,
              children: List.generate(
                4,
                (index) => Container(
                  height: 50,
                  color: Colors.blue,
                  child: Center(child: Text('Item $index')),
                ),
              ),
            ),
          ),
        ),
      );

      // Vérifier que le Container a bien les margin et padding spécifiés
      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.margin, margin);
      expect(container.padding, padding);
    });
  });

  group('SFResponsiveContainer', () {
    testWidgets('ne centre pas le contenu quand center=false', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFResponsiveContainer(
              maxWidth: 800,
              center: false,
              child: Container(
                height: 50,
                color: Colors.purple,
                child: const Center(child: Text('Contenu')),
              ),
            ),
          ),
        ),
      );

      // Vérifier qu'il n'y a pas de Center qui contient un ConstrainedBox
      final centerWithConstrainedBox = find.ancestor(
        of: find.byType(ConstrainedBox),
        matching: find.byType(Center),
      );
      expect(centerWithConstrainedBox, findsNothing);
    });

    testWidgets('utilise le padding responsive par défaut', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(size: const Size(320, 600)),
          child: MaterialApp(
            home: SFResponsiveContainer(
              child: Container(
                height: 50,
                color: Colors.purple,
                child: const Center(child: Text('Contenu')),
              ),
            ),
          ),
        ),
      );

      // Vérifier que le Container a bien le padding horizontal
      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.padding, isA<EdgeInsets>());
    });

    testWidgets('applique margin, padding et decoration correctement', (
      tester,
    ) async {
      const margin = EdgeInsets.all(15.0);
      const padding = EdgeInsets.all(10.0);
      const decoration = BoxDecoration(color: Colors.grey);

      await tester.pumpWidget(
        MaterialApp(
          home: SFResponsiveContainer(
            margin: margin,
            padding: padding,
            decoration: decoration,
            child: const Text('Contenu'),
          ),
        ),
      );

      // Vérifier que le Container a bien les propriétés spécifiées
      final container = tester.widget<Container>(find.byType(Container).first);
      expect(container.margin, margin);
      expect(container.padding, padding);
      expect(container.decoration, decoration);
    });
  });
}
