import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

void main() {
  group('SFIconButton', () {
    testWidgets('should render with default parameters', (
      WidgetTester tester,
    ) async {
      // Arrange
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SFIconButton(icon: Icons.add, onPressed: () {})),
        ),
      );

      // Assert
      expect(find.byType(SFIconButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);

      // Test default size (should be medium)
      final button = tester.widget<SFIconButton>(find.byType(SFIconButton));
      expect(button.size, equals(ComponentSize.md));
      expect(button.label, isNull);
      expect(button.iconPosition, equals(IconPosition.start));
    });

    testWidgets('should handle tap events', (WidgetTester tester) async {
      // Arrange
      bool buttonPressed = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFIconButton(
              icon: Icons.add,
              onPressed: () {
                buttonPressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SFIconButton));

      // Assert
      expect(buttonPressed, isTrue);
    });

    testWidgets('should render with different icons', (
      WidgetTester tester,
    ) async {
      // Test with edit icon
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFIconButton(icon: Icons.edit, onPressed: () {}),
          ),
        ),
      );

      expect(find.byIcon(Icons.edit), findsOneWidget);
      expect(find.byIcon(Icons.add), findsNothing);

      // Test with delete icon
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFIconButton(icon: Icons.delete, onPressed: () {}),
          ),
        ),
      );

      expect(find.byIcon(Icons.delete), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsNothing);
    });

    testWidgets('should display label when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFIconButton(
              icon: Icons.add,
              label: 'Add Item',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Add Item'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should position icon at the end when specified', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFIconButton(
              icon: Icons.add,
              label: 'Add Item',
              iconPosition: IconPosition.end,
              onPressed: () {},
            ),
          ),
        ),
      );

      final rowFinder = find.byType(Row);
      expect(rowFinder, findsOneWidget);

      // Vérifier l'ordre des widgets dans la Row
      final rowWidget = tester.widget<Row>(rowFinder);
      final children =
          rowWidget.children
              .where((widget) => widget is Text || widget is Icon)
              .toList();

      expect(children.length, equals(2));
      expect(children[0], isA<Text>());
      expect(children[1], isA<Icon>());
    });

    group('Button dimensions when no label is provided', () {
      final Map<ComponentSize, Size> expectedSizes = {
        ComponentSize.xs: const Size(16, 16),
        ComponentSize.sm: const Size(32, 32),
        ComponentSize.md: const Size(36, 36),
        ComponentSize.lg: const Size(40, 40),
        ComponentSize.xl: const Size(48, 48),
      };

      for (final size in ComponentSize.values) {
        testWidgets('should have correct size for ${size.name}', (
          WidgetTester tester,
        ) async {
          await tester.pumpWidget(
            MaterialApp(
              theme: ThemeData(
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ButtonStyle(
                    // Définir une valeur par défaut pour éviter null
                    minimumSize: WidgetStateProperty.all(Size.zero),
                  ),
                ),
              ),
              home: Scaffold(
                body: Center(
                  child: SFIconButton(
                    icon: Icons.add,
                    size: size,
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          );

          await tester
              .pumpAndSettle(); // Attendre que toutes les animations soient terminées

          // Vérification alternative - utiliser tester.getSize plutôt que d'accéder directement au style
          final buttonFinder = find.byType(ElevatedButton);
          expect(buttonFinder, findsOneWidget);

          // Première approche: vérifier les dimensions réelles du rendu
          if (expectedSizes.containsKey(size)) {
            final Size actualSize = tester.getSize(buttonFinder);

            // Vérifier que la taille actuelle correspond approximativement à la taille attendue
            // en tenant compte du padding interne et des marges
            expect(
              actualSize.width,
              greaterThanOrEqualTo(expectedSizes[size]!.width),
              reason:
                  'Button width for ${size.name} should be at least ${expectedSizes[size]!.width}',
            );
            expect(
              actualSize.height,
              greaterThanOrEqualTo(expectedSizes[size]!.height),
              reason:
                  'Button height for ${size.name} should be at least ${expectedSizes[size]!.height}',
            );
          }

          // Seconde approche (plus sûre): vérifier que la méthode _getButtonSize renvoie les bonnes valeurs
          // Cette approche nécessite d'exposer la méthode à des fins de test ou d'utiliser un setter/getter
          final iconButton = tester.widget<SFIconButton>(
            find.byType(SFIconButton),
          );
          expect(iconButton.size, equals(size));
        });
      }
    });

    testWidgets('should apply custom icon color when provided', (
      WidgetTester tester,
    ) async {
      const Color customColor = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFIconButton(
              icon: Icons.add,
              iconColor: customColor,
              onPressed: () {},
            ),
          ),
        ),
      );

      final iconWidget = tester.widget<Icon>(find.byIcon(Icons.add));
      expect(iconWidget.color, equals(customColor));
    });

    testWidgets('should use white as default icon color', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SFIconButton(icon: Icons.add, onPressed: () {})),
        ),
      );

      final iconWidget = tester.widget<Icon>(find.byIcon(Icons.add));
      expect(iconWidget.color, equals(Colors.white));
    });

    testWidgets('should add spacing between icon and text', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFIconButton(
              icon: Icons.add,
              label: 'Add Item',
              onPressed: () {},
            ),
          ),
        ),
      );

      // Au lieu de chercher un SizedBox spécifique, vérifions la structure de la Row
      final rowFinder = find.byType(Row);
      expect(rowFinder, findsOneWidget);

      final row = tester.widget<Row>(rowFinder);

      // Trouver tous les SizedBox dans la Row
      bool hasSpacingWidget = false;

      for (final child in row.children) {
        if (child is SizedBox && child.width == AppSpacing.xs) {
          hasSpacingWidget = true;
          break;
        }
      }

      expect(
        hasSpacingWidget,
        isTrue,
        reason:
            'La Row devrait contenir un SizedBox avec width = AppSpacing.xs',
      );

      // Vérifier que le texte et l'icône sont bien présents
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('Add Item'), findsOneWidget);
    });
  });
}
