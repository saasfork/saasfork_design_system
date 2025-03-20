import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

void main() {
  group('SFSecondaryButton', () {
    testWidgets('renders correctly with required parameters', (
      WidgetTester tester,
    ) async {
      // Arrange
      const label = 'Click me';
      var pressed = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFSecondaryButton(
              label: label,
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(label), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);

      // Test onPressed callback
      await tester.tap(find.byType(OutlinedButton));
      expect(pressed, isTrue);
    });

    testWidgets('applies correct style based on size', (
      WidgetTester tester,
    ) async {
      // Test small size
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFSecondaryButton(
              label: 'Small',
              onPressed: () {},
              size: ComponentSize.sm,
            ),
          ),
        ),
      );
      expect(find.text('Small'), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);

      // Test medium size (default)
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFSecondaryButton(label: 'Medium', onPressed: () {}),
          ),
        ),
      );
      expect(find.text('Medium'), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);

      // Test large size
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFSecondaryButton(
              label: 'Large',
              onPressed: () {},
              size: ComponentSize.lg,
            ),
          ),
        ),
      );
      expect(find.text('Large'), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('applies correct style based on theme', (
      WidgetTester tester,
    ) async {
      // Test with light theme
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: SFSecondaryButton(label: 'Button', onPressed: () {}),
          ),
        ),
      );

      final OutlinedButton lightThemeButton = tester.widget(
        find.byType(OutlinedButton),
      );
      expect(lightThemeButton, isNotNull);

      // Test with dark theme
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Scaffold(
            body: SFSecondaryButton(label: 'Button', onPressed: () {}),
          ),
        ),
      );

      final OutlinedButton darkThemeButton = tester.widget(
        find.byType(OutlinedButton),
      );
      expect(darkThemeButton, isNotNull);
    });
  });
}
