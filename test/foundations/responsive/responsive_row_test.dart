import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/foundations/responsive/responsive.dart';

void main() {
  group('SFResponsiveRow', () {
    testWidgets('creates a basic row with children', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFResponsiveRow(
              children: [
                SFResponsiveColumn(
                  xs: 6,
                  child: Container(key: const Key('column1')),
                ),
                SFResponsiveColumn(
                  xs: 6,
                  child: Container(key: const Key('column2')),
                ),
              ],
            ),
          ),
        ),
      );

      // Vérifie que les deux colonnes sont présentes
      expect(find.byKey(const Key('column1')), findsOneWidget);
      expect(find.byKey(const Key('column2')), findsOneWidget);

      // Vérifie que ResponsiveRowScope est créé
      final Element rowScopeElement = tester.element(
        find.byType(ResponsiveRowScope),
      );
      final ResponsiveRowScope rowScope =
          rowScopeElement.widget as ResponsiveRowScope;
      expect(rowScope.totalColumns, 12); // Valeur par défaut
      expect(rowScope.wrap, true); // Valeur par défaut
    });

    testWidgets('creates a row with custom totalColumns', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFResponsiveRow(
              totalColumns: 24, // Valeur personnalisée
              children: [SFResponsiveColumn(xs: 12, child: Container())],
            ),
          ),
        ),
      );

      final Element rowScopeElement = tester.element(
        find.byType(ResponsiveRowScope),
      );
      final ResponsiveRowScope rowScope =
          rowScopeElement.widget as ResponsiveRowScope;
      expect(rowScope.totalColumns, 24); // Valeur personnalisée
    });

    testWidgets('applies margin and padding correctly', (
      WidgetTester tester,
    ) async {
      const EdgeInsets testMargin = EdgeInsets.all(16);
      const EdgeInsets testPadding = EdgeInsets.all(8);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFResponsiveRow(
              margin: testMargin,
              padding: testPadding,
              children: [SFResponsiveColumn(xs: 12, child: Container())],
            ),
          ),
        ),
      );

      final Finder containerFinder = find.byType(Container).first;
      final Container container = tester.widget<Container>(containerFinder);

      expect(container.margin, testMargin);
      expect(container.padding, testPadding);
    });

    testWidgets('uses spacing correctly', (WidgetTester tester) async {
      const double testSpacing = 24.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFResponsiveRow(
              spacing: testSpacing,
              children: [
                SFResponsiveColumn(xs: 6, child: Container()),
                SFResponsiveColumn(xs: 6, child: Container()),
              ],
            ),
          ),
        ),
      );

      // Test Row spacing
      final Row rowWidget = tester.widget<Row>(find.byType(Row).first);
      expect(rowWidget.spacing, testSpacing);
    });

    testWidgets('handles wrap=false correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFResponsiveRow(
              wrap: false,
              children: [
                SFResponsiveColumn(xs: 6, child: Container()),
                SFResponsiveColumn(xs: 6, child: Container()),
                SFResponsiveColumn(xs: 6, child: Container()),
              ],
            ),
          ),
        ),
      );

      // Vérifie que Row est utilisé (et pas Wrap) quand wrap=false
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(Wrap), findsNothing);
    });

    testWidgets('wraps columns when total span exceeds totalColumns', (
      WidgetTester tester,
    ) async {
      // Set a fixed size for the screen using the non-deprecated API
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1.0;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFResponsiveRow(
              children: [
                SFResponsiveColumn(
                  xs: 8,
                  child: Container(key: const Key('col1')),
                ),
                SFResponsiveColumn(
                  xs: 8,
                  child: Container(key: const Key('col2')),
                ),
              ],
            ),
          ),
        ),
      );

      // Vérifie que Wrap est utilisé quand le total > totalColumns
      expect(find.byType(Wrap), findsOneWidget);
    });

    testWidgets('handles non-SFResponsiveColumn children', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFResponsiveRow(
              children: [
                SFResponsiveColumn(xs: 6, child: Container()),
                Container(key: const Key('regular-container')),
              ],
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('regular-container')), findsOneWidget);

      // Vérifie que le container régulier est enveloppé dans un Expanded quand il est dans un Row
      expect(
        find.ancestor(
          of: find.byKey(const Key('regular-container')),
          matching: find.byType(Expanded),
        ),
        findsOneWidget,
      );
    });

    testWidgets('ResponsiveRowScope is updated correctly', (
      WidgetTester tester,
    ) async {
      int buildCount = 0;
      late ResponsiveRowScope capturedScope;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFResponsiveRow(
              totalColumns: 16,
              wrap: false,
              children: [
                Builder(
                  builder: (context) {
                    buildCount++;
                    capturedScope = ResponsiveRowScope.of(context)!;
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      );

      expect(buildCount, 1);
      expect(capturedScope.totalColumns, 16);
      expect(capturedScope.wrap, false);

      // Changez les propriétés et reconstruisez
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFResponsiveRow(
              totalColumns: 24,
              wrap: true,
              children: [
                Builder(
                  builder: (context) {
                    buildCount++;
                    capturedScope = ResponsiveRowScope.of(context)!;
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      );

      expect(buildCount, 2);
      expect(capturedScope.totalColumns, 24);
      expect(capturedScope.wrap, true);
    });
  });
}
