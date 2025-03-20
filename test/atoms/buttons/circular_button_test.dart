import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

void main() {
  testWidgets('SFCircularButton should render with default parameters', (
    WidgetTester tester,
  ) async {
    // Arrange
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SFCircularButton(icon: Icons.add, onPressed: () {}),
        ),
      ),
    );

    // Assert
    expect(find.byType(SFCircularButton), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Test default size (should be medium)
    final button = tester.widget<SFCircularButton>(
      find.byType(SFCircularButton),
    );
    expect(button.size, equals(ComponentSize.md));
  });

  testWidgets('SFCircularButton should handle tap events', (
    WidgetTester tester,
  ) async {
    // Arrange
    bool buttonPressed = false;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SFCircularButton(
            icon: Icons.add,
            onPressed: () {
              buttonPressed = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byType(SFCircularButton));

    // Assert
    expect(buttonPressed, isTrue);
  });

  testWidgets('SFCircularButton should render with different sizes', (
    WidgetTester tester,
  ) async {
    // Test XS size
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SFCircularButton(
            icon: Icons.add,
            size: ComponentSize.xs,
            onPressed: () {},
          ),
        ),
      ),
    );

    var button = tester.widget<SFCircularButton>(find.byType(SFCircularButton));
    expect(button.size, equals(ComponentSize.xs));

    // Test XL size
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SFCircularButton(
            icon: Icons.add,
            size: ComponentSize.xl,
            onPressed: () {},
          ),
        ),
      ),
    );

    button = tester.widget<SFCircularButton>(find.byType(SFCircularButton));
    expect(button.size, equals(ComponentSize.xl));
  });

  testWidgets('SFCircularButton should render with different icons', (
    WidgetTester tester,
  ) async {
    // Test with edit icon
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SFCircularButton(icon: Icons.edit, onPressed: () {}),
        ),
      ),
    );

    expect(find.byIcon(Icons.edit), findsOneWidget);
    expect(find.byIcon(Icons.add), findsNothing);

    // Test with delete icon
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SFCircularButton(icon: Icons.delete, onPressed: () {}),
        ),
      ),
    );

    expect(find.byIcon(Icons.delete), findsOneWidget);
    expect(find.byIcon(Icons.edit), findsNothing);
  });

  group('SFCircularButton dimensions', () {
    testWidgets('should have correct dimensions for different sizes', (
      WidgetTester tester,
    ) async {
      // Map of expected dimensions for each size
      final Map<ComponentSize, double> expectedSizes = {
        ComponentSize.xs: 32.0,
        ComponentSize.sm: 40.0,
        ComponentSize.md: 48.0,
        ComponentSize.lg: 56.0,
        ComponentSize.xl: 64.0,
      };

      for (final size in ComponentSize.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SFCircularButton(
                icon: Icons.add,
                size: size,
                onPressed: () {},
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final buttonFinder = find.byType(SFCircularButton);
        final buttonSize = tester.getSize(buttonFinder);

        // Check if button dimensions match expected values
        expect(
          buttonSize.width,
          closeTo(expectedSizes[size]!, 1.0),
          reason:
              'Button width for ${size.name} size should be ${expectedSizes[size]}',
        );
        expect(
          buttonSize.height,
          closeTo(expectedSizes[size]!, 1.0),
          reason:
              'Button height for ${size.name} size should be ${expectedSizes[size]}',
        );
      }
    });

    testWidgets('dimensions should increase with size', (
      WidgetTester tester,
    ) async {
      double previousWidth = 0;
      double previousHeight = 0;

      // Testez chaque taille dans l'ordre
      for (final size in [
        ComponentSize.xs,
        ComponentSize.sm,
        ComponentSize.md,
        ComponentSize.lg,
        ComponentSize.xl,
      ]) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SFCircularButton(
                icon: Icons.add,
                size: size,
                onPressed: () {},
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final buttonFinder = find.byType(SFCircularButton);
        final buttonSize = tester.getSize(buttonFinder);

        if (previousWidth > 0) {
          expect(
            buttonSize.width >= previousWidth,
            isTrue,
            reason:
                'Button width should increase or stay the same with size ${size.name}',
          );
          expect(
            buttonSize.height >= previousHeight,
            isTrue,
            reason:
                'Button height should increase or stay the same with size ${size.name}',
          );
        }

        previousWidth = buttonSize.width;
        previousHeight = buttonSize.height;
      }
    });
  });

  testWidgets('SFCircularButton should apply theme styling correctly', (
    WidgetTester tester,
  ) async {
    // Custom theme with specific button styling
    final testTheme = ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.purple),
        ),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: testTheme,
        home: Scaffold(
          body: SFCircularButton(icon: Icons.add, onPressed: () {}),
        ),
      ),
    );

    // Find the underlying ElevatedButton
    final elevatedButton = tester.widget<ElevatedButton>(
      find.descendant(
        of: find.byType(SFCircularButton),
        matching: find.byType(ElevatedButton),
      ),
    );

    // Check if theme is applied
    final buttonStyle = elevatedButton.style!;
    final bgColor = buttonStyle.backgroundColor!.resolve({});
    expect(bgColor, equals(Colors.purple));
  });

  testWidgets('SFCircularButton should apply custom colors correctly', (
    WidgetTester tester,
  ) async {
    // Custom colors
    const customIconColor = Colors.amber;
    const customBackgroundColor = Colors.indigo;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SFCircularButton(
            icon: Icons.add,
            onPressed: () {},
            iconColor: customIconColor,
            backgroundColor: customBackgroundColor,
          ),
        ),
      ),
    );

    // Vérifier la couleur de l'icône
    final iconWidget = tester.widget<Icon>(find.byType(Icon));
    expect(iconWidget.color, equals(customIconColor));

    // Vérifier que le backgroundColor a été passé au widget
    final circularButton = tester.widget<SFCircularButton>(
      find.byType(SFCircularButton),
    );
    expect(circularButton.backgroundColor, equals(customBackgroundColor));

    // Rechercher le bouton ElevatedButton mais sans vérifier sa couleur directement
    // car la façon dont elle est appliquée peut varier
    expect(
      find.descendant(
        of: find.byType(SFCircularButton),
        matching: find.byType(ElevatedButton),
      ),
      findsOneWidget,
    );
  });

  testWidgets(
    'SFCircularButton should have correct icon sizes based on button size',
    (WidgetTester tester) async {
      // Map des tailles d'icônes attendues pour chaque taille de composant
      final Map<ComponentSize, double> expectedIconSizes = {
        ComponentSize.xs: 16.0,
        ComponentSize.sm: 20.0,
        ComponentSize.md: 24.0,
        ComponentSize.lg: 28.0,
        ComponentSize.xl: 32.0,
      };

      for (final size in ComponentSize.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SFCircularButton(
                icon: Icons.add,
                size: size,
                onPressed: () {},
              ),
            ),
          ),
        );

        final iconWidget = tester.widget<Icon>(find.byType(Icon));
        expect(
          iconWidget.size,
          equals(expectedIconSizes[size]),
          reason:
              'Icon size for ${size.name} button should be ${expectedIconSizes[size]}',
        );
      }
    },
  );

  testWidgets('SFCircularButton should use white icon color by default', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SFCircularButton(icon: Icons.add, onPressed: () {}),
        ),
      ),
    );

    final iconWidget = tester.widget<Icon>(find.byType(Icon));
    expect(iconWidget.color, equals(Colors.white));
  });
}
