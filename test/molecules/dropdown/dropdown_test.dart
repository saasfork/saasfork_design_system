import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

void main() {
  group('SFDropdown', () {
    final options = [
      DropdownOption(label: 'Option 1', value: '1'),
      DropdownOption(label: 'Option 2', value: '2'),
      DropdownOption(label: 'Option 3', value: '3'),
    ];

    testWidgets('displays placeholder when no value is selected', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFDropdown(
              options: options,
              onChanged: (_) {},
              placeholder: 'Select an option',
            ),
          ),
        ),
      );

      expect(find.text('Select an option'), findsOneWidget);
    });

    testWidgets('opens dropdown menu when tapped', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SFDropdown(options: options, onChanged: (_) {})),
        ),
      );

      await tester.tap(find.byType(SFDropdown));
      await tester.pumpAndSettle();

      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
      expect(find.text('Option 3'), findsOneWidget);
    });

    testWidgets('closes dropdown menu when an option is selected', (
      tester,
    ) async {
      String? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFDropdown(
              options: options,
              onChanged: (value) {
                selectedValue = value;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SFDropdown));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Option 2'));
      await tester.pumpAndSettle();

      expect(selectedValue, '2');
      expect(find.text('Option 2'), findsNothing); // Dropdown should close
    });

    testWidgets('displays selected value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFDropdown(
              options: options,
              selectedValue: '3',
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Option 3'), findsOneWidget);
    });
  });
}
