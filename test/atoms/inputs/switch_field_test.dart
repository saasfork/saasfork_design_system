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
  });
}
