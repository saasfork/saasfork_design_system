import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/atoms/icons/icon.dart';
import 'package:saasfork_design_system/foundations/foundations.dart';

void main() {
  testWidgets('SFIcon affiche une icône transparente par défaut', (
    WidgetTester tester,
  ) async {
    // Arrange & Act
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: Center(child: SFIcon()))),
    );

    // Assert
    expect(find.byType(Icon), findsOneWidget);
    expect(find.byType(Container), findsNothing);

    final iconWidget = tester.widget<Icon>(find.byType(Icon));
    expect(iconWidget.icon, equals(Icons.star));
    expect(
      iconWidget.size,
      equals(AppSizes.getIconSize(ComponentSize.md) * 1.2),
    );
  });

  testWidgets('SFIcon affiche une icône avec un fond arrondi', (
    WidgetTester tester,
  ) async {
    // Arrange & Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: SFIcon(
              icon: Icons.check,
              iconType: SFIconType.rounded,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );

    // Assert
    expect(find.byType(Icon), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);

    final containerWidget = tester.widget<Container>(find.byType(Container));
    final decoration = containerWidget.decoration as BoxDecoration;
    expect(decoration.shape, equals(BoxShape.circle));
    expect((decoration.color as Color).alpha, equals(26)); // 0.1 * 255 ≈ 26

    final iconWidget = tester.widget<Icon>(find.byType(Icon));
    expect(iconWidget.icon, equals(Icons.check));
    expect(iconWidget.color, equals(Colors.blue));
  });

  testWidgets('SFIcon affiche une icône avec un fond carré', (
    WidgetTester tester,
  ) async {
    // Arrange & Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: SFIcon(
              icon: Icons.add,
              iconType: SFIconType.square,
              color: Colors.red,
              size: ComponentSize.lg,
            ),
          ),
        ),
      ),
    );

    // Assert
    expect(find.byType(Icon), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);

    final containerWidget = tester.widget<Container>(find.byType(Container));
    final decoration = containerWidget.decoration as BoxDecoration;
    expect(decoration.borderRadius, equals(BorderRadius.circular(8)));
    expect((decoration.color as Color).alpha, equals(26)); // 0.1 * 255 ≈ 26

    final iconWidget = tester.widget<Icon>(find.byType(Icon));
    expect(iconWidget.icon, equals(Icons.add));
    expect(iconWidget.color, equals(Colors.red));
    expect(
      iconWidget.size,
      equals(AppSizes.getIconSize(ComponentSize.lg) * 1.2),
    );
  });

  testWidgets('SFIcon respecte les propriétés de taille personnalisées', (
    WidgetTester tester,
  ) async {
    // Arrange & Act
    const double customFactor = 2.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: SFIcon(
              size: ComponentSize.sm,
              factorSize: customFactor,
              padding: ComponentSize.sm,
            ),
          ),
        ),
      ),
    );

    // Assert
    final iconWidget = tester.widget<Icon>(find.byType(Icon));
    expect(
      iconWidget.size,
      equals(AppSizes.getIconSize(ComponentSize.sm) * customFactor),
    );
  });

  testWidgets(
    'SFIcon utilise la couleur du thème si aucune couleur n\'est spécifiée',
    (WidgetTester tester) async {
      // Arrange & Act
      final ThemeData theme = ThemeData(primaryColor: Colors.purple);

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(body: Center(child: SFIcon())),
        ),
      );

      // Assert
      final iconWidget = tester.widget<Icon>(find.byType(Icon));
      expect(iconWidget.color, equals(theme.primaryColor));
    },
  );
}
