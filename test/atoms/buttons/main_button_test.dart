import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/atoms/buttons/main_button.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

void main() {
  group('SFMainButton', () {
    testWidgets('should render correctly with default size', (
      WidgetTester tester,
    ) async {
      // ARRANGE
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFMainButton(label: 'Test Button', onPressed: () {}),
          ),
        ),
      );

      // ASSERT
      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should call onPressed callback when tapped', (
      WidgetTester tester,
    ) async {
      // ARRANGE
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFMainButton(
              label: 'Test Button',
              onPressed: () {
                wasPressed = true;
              },
            ),
          ),
        ),
      );

      // ACT
      await tester.tap(find.byType(SFMainButton));
      await tester.pump();

      // ASSERT
      expect(wasPressed, isTrue);
    });

    testWidgets('should use the provided label', (WidgetTester tester) async {
      // ARRANGE
      const testLabel = 'Custom Label';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFMainButton(label: testLabel, onPressed: () {}),
          ),
        ),
      );

      // ASSERT
      expect(find.text(testLabel), findsOneWidget);
    });
  });
}
