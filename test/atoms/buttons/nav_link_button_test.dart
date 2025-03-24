import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

void main() {
  group('NavLinkItem', () {
    testWidgets('renders correctly with label', (WidgetTester tester) async {
      // Arrange
      const String label = 'Test Link';
      bool wasTapped = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFNavLinkItem(
              link: SFNavLink(
                label: label,
                onPress: () {
                  wasTapped = true;
                },
              ),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(label), findsOneWidget);
      expect(find.byType(Icon), findsNothing);

      // Test onPress callback
      await tester.tap(find.byType(SFNavLinkItem));
      expect(wasTapped, isTrue);
    });

    testWidgets('renders correctly with icon and label', (
      WidgetTester tester,
    ) async {
      // Arrange
      const String label = 'Test Link';
      const IconData testIcon = Icons.home;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFNavLinkItem(
              link: SFNavLink(label: label, onPress: () {}, icon: testIcon),
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(label), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('applies correct styles when active', (
      WidgetTester tester,
    ) async {
      // Arrange
      const String label = 'Active Link';

      // Act - Light Mode, Active
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: SFNavLinkItem(
              link: SFNavLink(label: label, onPress: () {}, isActive: true),
            ),
          ),
        ),
      );

      // Assert
      final Container container = tester.widget(find.byType(Container));
      final BoxDecoration decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(AppColors.grey.s50));

      final Text text = tester.widget(find.text(label));
      expect(text.style?.color, equals(AppColors.grey.s600));
    });

    testWidgets('applies correct styles when inactive', (
      WidgetTester tester,
    ) async {
      // Arrange
      const String label = 'Inactive Link';

      // Act - Light Mode, Inactive
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Scaffold(
            body: SFNavLinkItem(
              link: SFNavLink(label: label, onPress: () {}, isActive: false),
            ),
          ),
        ),
      );

      // Assert
      final Container container = tester.widget(find.byType(Container));
      final BoxDecoration decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(Colors.transparent));

      final Text text = tester.widget(find.text(label));
      expect(text.style?.color, equals(AppColors.grey.s600));
    });

    testWidgets('adapts to dark mode when active', (WidgetTester tester) async {
      // Arrange
      const String label = 'Dark Mode Active Link';

      // Act - Dark Mode, Active
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Scaffold(
            body: SFNavLinkItem(
              link: SFNavLink(label: label, onPress: () {}, isActive: true),
            ),
          ),
        ),
      );

      // Assert
      final Container container = tester.widget(find.byType(Container));
      final BoxDecoration decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(AppColors.grey.s700));

      final Text text = tester.widget(find.text(label));
      expect(text.style?.color, equals(AppColors.grey.s50));
    });

    testWidgets('adapts to dark mode when inactive', (
      WidgetTester tester,
    ) async {
      // Arrange
      const String label = 'Dark Mode Inactive Link';

      // Act - Dark Mode, Inactive
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Scaffold(
            body: SFNavLinkItem(
              link: SFNavLink(label: label, onPress: () {}, isActive: false),
            ),
          ),
        ),
      );

      // Assert
      final Container container = tester.widget(find.byType(Container));
      final BoxDecoration decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(Colors.transparent));

      final Text text = tester.widget(find.text(label));
      expect(text.style?.color, equals(AppColors.grey.s300));
    });
  });
}
