import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/atoms/inputs/switch_field.dart';

void main() {
  group('SFSwitchField', () {
    testWidgets('should render correctly when value is true', (
      WidgetTester tester,
    ) async {
      // Arrange
      const bool switchValue = true;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFSwitchField(value: switchValue, onChanged: (_) {}),
          ),
        ),
      );

      // Assert
      expect(find.byType(SFSwitchField), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);

      final Switch switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.value, switchValue);
    });

    testWidgets('should render correctly when value is false', (
      WidgetTester tester,
    ) async {
      // Arrange
      const bool switchValue = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFSwitchField(value: switchValue, onChanged: (_) {}),
          ),
        ),
      );

      // Assert
      expect(find.byType(SFSwitchField), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);

      final Switch switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.value, switchValue);
    });

    testWidgets('should call onChanged callback when tapped', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool switchValue = false;
      bool callbackCalled = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFSwitchField(
              value: switchValue,
              onChanged: (newValue) {
                switchValue = newValue;
                callbackCalled = true;
              },
            ),
          ),
        ),
      );

      // Tap on the switch
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      // Assert
      expect(callbackCalled, isTrue);
      expect(
        switchValue,
        isTrue,
      ); // La valeur doit être passée à true après le tap
    });

    testWidgets('should pass the correct value to the Switch widget', (
      WidgetTester tester,
    ) async {
      // Arrange
      for (final testValue in [true, false]) {
        // Act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SFSwitchField(value: testValue, onChanged: (_) {}),
            ),
          ),
        );

        // Assert
        final Switch switchWidget = tester.widget<Switch>(find.byType(Switch));
        expect(switchWidget.value, testValue);
      }
    });

    testWidgets('should not call onChanged when disabled', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool callbackCalled = false;
      const bool switchValue = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFSwitchField(
              value: switchValue,
              isDisabled: true,
              onChanged: (_) {
                callbackCalled = true;
              },
            ),
          ),
        ),
      );

      // Tap on the switch
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      // Assert
      expect(callbackCalled, isFalse);

      // Vérifier que la valeur n'a pas changé
      final Switch switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.value, switchValue);

      // Vérifier que onChanged est null quand isDisabled est true
      expect(switchWidget.onChanged, isNull);
    });

    testWidgets('should render with reduced opacity when disabled', (
      WidgetTester tester,
    ) async {
      // Arrange
      const bool switchValue = true;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFSwitchField(
              value: switchValue,
              isDisabled: true,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      // Assert
      // Au lieu de chercher tous les widgets Opacity, on cherche l'opacité du widget Switch
      final Widget opacityWidget = tester.widget<Opacity>(
        find.ancestor(of: find.byType(Switch), matching: find.byType(Opacity)),
      );

      expect(opacityWidget, isA<Opacity>());
      expect((opacityWidget as Opacity).opacity, 0.5);
    });

    testWidgets('should wrap with Tooltip when disabled', (
      WidgetTester tester,
    ) async {
      // Arrange
      const bool switchValue = true;
      const String tooltipMessage = 'Ce champ est désactivé';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFSwitchField(
              value: switchValue,
              isDisabled: true,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(Tooltip), findsOneWidget);

      final Tooltip tooltip = tester.widget<Tooltip>(find.byType(Tooltip));
      expect(tooltip.message, tooltipMessage);
      expect(tooltip.preferBelow, isFalse);
    });

    testWidgets('should accept custom tooltip message', (
      WidgetTester tester,
    ) async {
      // Arrange
      const bool switchValue = true;
      const String customTooltip = 'Fonctionnalité Premium';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFSwitchField(
              value: switchValue,
              isDisabled: true,
              tooltipMessage: customTooltip,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(Tooltip), findsOneWidget);

      final Tooltip tooltip = tester.widget<Tooltip>(find.byType(Tooltip));
      expect(tooltip.message, customTooltip);
    });

    testWidgets('should not wrap with Tooltip when enabled', (
      WidgetTester tester,
    ) async {
      // Arrange
      const bool switchValue = true;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFSwitchField(
              value: switchValue,
              isDisabled: false,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(Tooltip), findsNothing);
    });
  });
}
