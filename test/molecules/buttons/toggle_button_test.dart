import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

void main() {
  group('SFToggleButton', () {
    testWidgets('initialise correctement en mode clair (initialValue=false)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFToggleButton(onToggle: (value) {}, initialValue: false),
          ),
        ),
      );

      // Vérifie que l'icône du mode clair est affichée
      expect(find.byIcon(Icons.light_mode_rounded), findsOneWidget);
      expect(find.byIcon(Icons.dark_mode_rounded), findsNothing);

      // Vérifie que le bouton a la couleur correcte (celle du mode clair)
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(SFToggleButton),
          matching: find.byType(Container),
        ),
      );

      // Vérifie la couleur du bouton
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(AppColors.orange));
    });

    testWidgets('initialise correctement en mode sombre (initialValue=true)', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFToggleButton(onToggle: (value) {}, initialValue: true),
          ),
        ),
      );

      // Vérifie que l'icône du mode sombre est affichée
      expect(find.byIcon(Icons.dark_mode_rounded), findsOneWidget);
      expect(find.byIcon(Icons.light_mode_rounded), findsNothing);

      // Vérifie que le bouton a la couleur correcte (celle du mode sombre)
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(SFToggleButton),
          matching: find.byType(Container),
        ),
      );

      // Vérifie la couleur du bouton
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(AppColors.indigo));
    });

    testWidgets('bascule du mode clair au mode sombre lors d\'un tap', (
      WidgetTester tester,
    ) async {
      bool? toggleValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFToggleButton(
              onToggle: (value) => toggleValue = value,
              initialValue: false,
            ),
          ),
        ),
      );

      // Vérifie l'état initial
      expect(find.byIcon(Icons.light_mode_rounded), findsOneWidget);

      // Tap sur le bouton
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle(); // Attend que l'animation se termine

      // Vérifie que l'état a changé
      expect(find.byIcon(Icons.dark_mode_rounded), findsOneWidget);
      expect(find.byIcon(Icons.light_mode_rounded), findsNothing);

      // Vérifie que le callback a été appelé avec la bonne valeur
      expect(toggleValue, isTrue);

      // Vérifie que la couleur a changé
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(SFToggleButton),
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(AppColors.indigo));
    });

    testWidgets('bascule du mode sombre au mode clair lors d\'un tap', (
      WidgetTester tester,
    ) async {
      bool? toggleValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFToggleButton(
              onToggle: (value) => toggleValue = value,
              initialValue: true,
            ),
          ),
        ),
      );

      // Vérifie l'état initial
      expect(find.byIcon(Icons.dark_mode_rounded), findsOneWidget);

      // Tap sur le bouton
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle(); // Attend que l'animation se termine

      // Vérifie que l'état a changé
      expect(find.byIcon(Icons.light_mode_rounded), findsOneWidget);
      expect(find.byIcon(Icons.dark_mode_rounded), findsNothing);

      // Vérifie que le callback a été appelé avec la bonne valeur
      expect(toggleValue, isFalse);

      // Vérifie que la couleur a changé
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(SFToggleButton),
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(AppColors.orange));
    });

    testWidgets('utilise les couleurs personnalisées si elles sont fournies', (
      WidgetTester tester,
    ) async {
      const customLightColor = Colors.pink;
      const customDarkColor = Colors.purple;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFToggleButton(
              onToggle: (value) {},
              initialValue: false,
              lightModeColor: customLightColor,
              darkModeColor: customDarkColor,
            ),
          ),
        ),
      );

      // Vérifie la couleur personnalisée en mode clair
      var container = tester.widget<Container>(
        find.descendant(
          of: find.byType(SFToggleButton),
          matching: find.byType(Container),
        ),
      );
      var decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(customLightColor));

      // Tap pour passer en mode sombre
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Vérifie la couleur personnalisée en mode sombre
      container = tester.widget<Container>(
        find.descendant(
          of: find.byType(SFToggleButton),
          matching: find.byType(Container),
        ),
      );
      decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(customDarkColor));
    });

    testWidgets('utilise les icônes personnalisées si elles sont fournies', (
      WidgetTester tester,
    ) async {
      const customLightIcon = Icon(Icons.wb_sunny);
      const customDarkIcon = Icon(Icons.nightlight_round);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFToggleButton(
              onToggle: (value) {},
              initialValue: false,
              lightIcon: customLightIcon,
              darkIcon: customDarkIcon,
            ),
          ),
        ),
      );

      // Vérifie l'icône personnalisée en mode clair
      expect(find.byIcon(Icons.wb_sunny), findsOneWidget);

      // Tap pour passer en mode sombre
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Vérifie l'icône personnalisée en mode sombre
      expect(find.byIcon(Icons.nightlight_round), findsOneWidget);
    });

    testWidgets(
      'utilise les couleurs d\'icône du thème pour les boutons transparents',
      (WidgetTester tester) async {
        // Test avec thème clair
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light().copyWith(
              iconTheme: IconThemeData(color: AppColors.grey.s800),
            ),
            home: Scaffold(
              body: SFToggleButton(
                onToggle: (value) {},
                lightModeColor: Colors.transparent,
                darkModeColor: Colors.transparent,
              ),
            ),
          ),
        );

        // Vérifier que le bouton est transparent
        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(SFToggleButton),
            matching: find.byType(Container),
          ),
        );
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, equals(Colors.transparent));

        // Vérifier la couleur de l'icône (devrait utiliser la couleur du thème)
        final icon = tester.widget<Icon>(find.byType(Icon));
        final expectedColor = Color(
          0xFF1D1B20,
        ); // Équivalent à la couleur réelle
        expect(icon.color, equals(expectedColor));
      },
    );

    testWidgets('préfère les couleurs d\'icône personnalisées au thème', (
      WidgetTester tester,
    ) async {
      const customLightIconColor = Colors.yellow;
      const customDarkIconColor = Colors.green;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: SFToggleButton(
              onToggle: (value) {},
              initialValue: false,
              lightIconColor: customLightIconColor,
              darkIconColor: customDarkIconColor,
              lightModeColor: Colors.transparent,
              darkModeColor: Colors.transparent,
            ),
          ),
        ),
      );

      // Vérifier la couleur d'icône personnalisée en mode clair
      var icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.color, equals(customLightIconColor));

      // Tap pour passer en mode sombre
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Vérifier la couleur d'icône personnalisée en mode sombre
      icon = tester.widget<Icon>(find.byType(Icon));
      expect(icon.color, equals(customDarkIconColor));
    });
  });
}
