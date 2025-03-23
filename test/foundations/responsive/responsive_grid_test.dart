import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/foundations/responsive/responsive_grid.dart';

void main() {
  group('ResponsiveGrid', () {
    testWidgets('crée une grille avec le nombre correct d\'enfants', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveGrid(
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
            home: ResponsiveGrid(
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
            home: ResponsiveGrid(
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

  group('ResponsiveRow', () {
    testWidgets('utilise Row quand wrap est false', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveRow(
            wrap: false,
            spacing: 10,
            children: List.generate(
              3,
              (index) => Container(
                height: 50,
                color: Colors.green,
                child: Center(child: Text('Col $index')),
              ),
            ),
          ),
        ),
      );

      // Vérifier que Row est utilisé comme conteneur principal
      final rowFinder = find.byType(Row);
      expect(rowFinder, findsOneWidget);

      // Vérifier que les Expanded sont créés pour chaque enfant
      final expandedFinder = find.byType(Expanded);
      expect(expandedFinder, findsNWidgets(3));

      // Vérifier que les SizedBox de spacing sont présents
      // Compter les SizedBox avec width=10
      int spacerCount = 0;
      tester.widgetList<SizedBox>(find.byType(SizedBox)).forEach((sizedBox) {
        if (sizedBox.width == 10) {
          spacerCount++;
        }
      });

      // Vérifier qu'on a bien 2 espaceurs (entre 3 éléments)
      expect(spacerCount, 2);
    });

    testWidgets('utilise Wrap quand wrap est true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveRow(
            wrap: true,
            spacing: 15,
            children: List.generate(
              3,
              (index) => Container(
                height: 50,
                width: 100,
                color: Colors.green,
                child: Center(child: Text('Col $index')),
              ),
            ),
          ),
        ),
      );

      // Vérifier que Wrap est utilisé comme conteneur principal
      final wrapFinder = find.byType(Wrap);
      expect(wrapFinder, findsOneWidget);

      // Vérifier les paramètres du Wrap
      final wrap = tester.widget<Wrap>(wrapFinder);
      expect(wrap.spacing, 15);
      expect(wrap.runSpacing, 15);
    });

    testWidgets('applique margin et padding correctement', (tester) async {
      const margin = EdgeInsets.all(15.0);
      const padding = EdgeInsets.all(10.0);

      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveRow(
            margin: margin,
            padding: padding,
            children: List.generate(
              3,
              (index) => Container(
                height: 50,
                color: Colors.green,
                child: Center(child: Text('Col $index')),
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

  group('ResponsiveColumn', () {
    Widget buildTestWidget(Widget child) {
      return MaterialApp(home: Scaffold(body: child));
    }

    testWidgets('applique padding et décoration', (tester) async {
      const padding = EdgeInsets.all(10.0);
      const decoration = BoxDecoration(color: Colors.amber);
      const alignment = Alignment.center;

      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(size: const Size(320, 600)), // Taille mobile
          child: buildTestWidget(
            ResponsiveColumn(
              xs: 6,
              padding: padding,
              decoration: decoration,
              alignment: alignment,
              child: const Text('Contenu'),
            ),
          ),
        ),
      );

      // Chercher le Container à l'intérieur du FractionallySizedBox
      final fractionFinder = find.byType(FractionallySizedBox);
      final containerInFraction = find.descendant(
        of: fractionFinder,
        matching: find.byType(Container),
      );

      // Vérifier le Container et ses propriétés
      expect(containerInFraction, findsOneWidget);
      final container = tester.widget<Container>(containerInFraction);
      expect(container.padding, padding);
      expect(container.decoration, decoration);

      // Vérifier l'alignement
      final alignFinder = find.descendant(
        of: containerInFraction,
        matching: find.byType(Align),
      );
      expect(alignFinder, findsOneWidget);
      final align = tester.widget<Align>(alignFinder);
      expect(align.alignment, alignment);
    });
  });

  group('ResponsiveContainer', () {
    testWidgets('ne centre pas le contenu quand center=false', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ResponsiveContainer(
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
            home: ResponsiveContainer(
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
          home: ResponsiveContainer(
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
