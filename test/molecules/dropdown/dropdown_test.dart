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
              builder:
                  (context, option, isOpen) => SelectedFieldDropdown(
                    value: option,
                    isOpen: isOpen,
                    isError: false,
                    size: ComponentSize.md,
                  ),
            ),
          ),
        ),
      );

      expect(find.text('Select an option'), findsOneWidget);
    });

    testWidgets('opens dropdown menu when tapped', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFDropdown(
              options: options,
              onChanged: (_) {},
              builder:
                  (context, option, isOpen) => SelectedFieldDropdown(
                    value: option,
                    isOpen: isOpen,
                    isError: false,
                    size: ComponentSize.md,
                  ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SFDropdown));
      await tester.pumpAndSettle();

      // Vérifier que les options sont affichées
      for (final option in options) {
        expect(find.text(option.label), findsOneWidget);
      }
    });

    testWidgets('displays selected value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFDropdown(
              options: options,
              selectedValue: '3',
              onChanged: (_) {},
              builder:
                  (context, option, isOpen) => SelectedFieldDropdown(
                    value: option,
                    isOpen: isOpen,
                    isError: false,
                    size: ComponentSize.md,
                  ),
            ),
          ),
        ),
      );

      expect(find.text('Option 3'), findsOneWidget);
    });
  });
}
