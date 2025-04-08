import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/organisms/structure/footer_section.dart';

void main() {
  group('SFFooterSection', () {
    testWidgets('displays default values correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: SFFooterSection())),
      );

      // Default values: © 2024 Your Company, Inc. All rights reserved.
      expect(
        find.text('© 2024 Your Company, Inc. All rights reserved.'),
        findsOneWidget,
      );
    });

    testWidgets('hides copyright symbol when showCopyright is false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SFFooterSection(showCopyright: false)),
        ),
      );

      // Without copyright: 2024 Your Company, Inc. All rights reserved.
      expect(
        find.text('2024 Your Company, Inc. All rights reserved.'),
        findsOneWidget,
      );
    });

    testWidgets('customizes company name correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SFFooterSection(companyName: 'Test Company')),
        ),
      );

      expect(
        find.text('© 2024 Test Company All rights reserved.'),
        findsOneWidget,
      );
    });

    testWidgets('customizes year correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: SFFooterSection(year: 2023))),
      );

      expect(
        find.text('© 2023 Your Company, Inc. All rights reserved.'),
        findsOneWidget,
      );
    });

    testWidgets('hides year when year is 0', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: SFFooterSection(year: 0))),
      );

      expect(
        find.text('© Your Company, Inc. All rights reserved.'),
        findsOneWidget,
      );
    });

    testWidgets(
      'hides all rights reserved when showAllRightsReserved is false',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: SFFooterSection(showAllRightsReserved: false)),
          ),
        );

        expect(find.text('© 2024 Your Company, Inc.'), findsOneWidget);
      },
    );

    testWidgets('combines multiple parameter changes correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SFFooterSection(
              showCopyright: false,
              companyName: 'Acme Corp',
              year: 2022,
              showAllRightsReserved: false,
            ),
          ),
        ),
      );

      expect(find.text('2022 Acme Corp'), findsOneWidget);
    });

    testWidgets('handles empty company name', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SFFooterSection(companyName: '')),
        ),
      );

      expect(find.text('© 2024 All rights reserved.'), findsOneWidget);
    });
  });
}
