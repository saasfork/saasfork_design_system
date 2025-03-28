import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

void main() {
  group('SFTextField', () {
    testWidgets('renders correctly with default props', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(inputDecorationTheme: const InputDecorationTheme()),
          home: const Scaffold(body: SFTextField(placeholder: 'Enter text')),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Enter text'), findsOneWidget);

      final TextField textField = tester.widget(find.byType(TextField));
      expect(textField.controller, isNull);
      expect(textField.decoration!.hintText, equals('Enter text'));
      expect(textField.decoration!.filled, isFalse);
    });

    testWidgets('renders in error state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.red.s300),
              ),
            ),
          ),
          home: const Scaffold(
            body: SFTextField(placeholder: 'Enter text', isInError: true),
          ),
        ),
      );

      final TextField textField = tester.widget(find.byType(TextField));
      expect(textField.decoration!.enabledBorder, isA<OutlineInputBorder>());

      final OutlineInputBorder border =
          textField.decoration!.enabledBorder as OutlineInputBorder;
      expect(border.borderSide.color, equals(AppColors.red.s300));
    });

    testWidgets('renders with different sizes', (WidgetTester tester) async {
      for (final size in ComponentSize.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: SFTextField(placeholder: 'Test', size: size)),
          ),
        );

        final TextField textField = tester.widget(find.byType(TextField));
        expect(
          textField.decoration!.contentPadding,
          equals(AppSizes.getInputPadding(size)),
        );
        expect(
          textField.decoration!.constraints,
          equals(AppSizes.getInputConstraints(size)),
        );

        await tester.pumpAndSettle();
      }
    });

    testWidgets('renders with custom background color', (
      WidgetTester tester,
    ) async {
      const Color customColor = Colors.amber;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SFTextField(
              placeholder: 'Test',
              backgroundColor: customColor,
            ),
          ),
        ),
      );

      final TextField textField = tester.widget(find.byType(TextField));
      expect(textField.decoration!.filled, isTrue);
      expect(textField.decoration!.fillColor, equals(customColor));
    });

    testWidgets('controller works correctly', (WidgetTester tester) async {
      final controller = TextEditingController(text: 'Initial text');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFTextField(placeholder: 'Test', controller: controller),
          ),
        ),
      );

      expect(find.text('Initial text'), findsOneWidget);

      controller.text = 'Updated text';
      await tester.pump();

      expect(find.text('Updated text'), findsOneWidget);
    });

    testWidgets('renders with prefix text correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.sm),
              ),
            ),
          ),
          home: const Scaffold(
            body: SFTextField(placeholder: 'Test', prefixText: 'Prefix'),
          ),
        ),
      );

      expect(find.text('Prefix'), findsOneWidget);

      // Trouver tous les Container qui contiennent le texte de préfixe
      final Finder containerFinder = find.ancestor(
        of: find.text('Prefix'),
        matching: find.byType(Container),
      );
      expect(containerFinder, findsWidgets);

      // Chercher parmi ces containers celui qui a une décoration
      bool foundDecoratedContainer = false;
      for (int i = 0; i < tester.widgetList(containerFinder).length; i++) {
        final Container container = tester.widget<Container>(
          containerFinder.at(i),
        );
        if (container.decoration != null) {
          foundDecoratedContainer = true;
          final BoxDecoration decoration =
              container.decoration as BoxDecoration;
          expect(decoration.color, equals(AppColors.gray.s50));
          break;
        }
      }
      expect(
        foundDecoratedContainer,
        isTrue,
        reason: 'Aucun container avec décoration trouvé',
      );
    });

    testWidgets('prefix has error styling when in error state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.sm),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.red.s300),
                borderRadius: BorderRadius.circular(AppSpacing.sm),
              ),
            ),
          ),
          home: const Scaffold(
            body: SFTextField(
              placeholder: 'Test',
              prefixText: 'Prefix',
              isInError: true,
            ),
          ),
        ),
      );

      expect(find.text('Prefix'), findsOneWidget);

      // Trouver tous les Container qui contiennent le texte de préfixe
      final Finder containerFinder = find.ancestor(
        of: find.text('Prefix'),
        matching: find.byType(Container),
      );
      expect(containerFinder, findsWidgets);

      // Chercher parmi ces containers celui qui a une décoration
      bool foundDecoratedContainer = false;
      for (int i = 0; i < tester.widgetList(containerFinder).length; i++) {
        final Container container = tester.widget<Container>(
          containerFinder.at(i),
        );
        if (container.decoration != null) {
          foundDecoratedContainer = true;
          final BoxDecoration decoration =
              container.decoration as BoxDecoration;
          expect(decoration.color, equals(AppColors.red.s50));
          break;
        }
      }
      expect(
        foundDecoratedContainer,
        isTrue,
        reason: 'Aucun container avec décoration trouvé',
      );
    });

    testWidgets('prefix text has correct border radius', (
      WidgetTester tester,
    ) async {
      const double testBorderRadius = 12.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(testBorderRadius),
              ),
            ),
          ),
          home: const Scaffold(
            body: SFTextField(placeholder: 'Test', prefixText: 'Prefix'),
          ),
        ),
      );

      // Trouver tous les Container qui contiennent le texte de préfixe
      final Finder containerFinder = find.ancestor(
        of: find.text('Prefix'),
        matching: find.byType(Container),
      );

      // Chercher parmi ces containers celui qui a une décoration avec borderRadius
      bool foundDecoratedContainer = false;
      for (int i = 0; i < tester.widgetList(containerFinder).length; i++) {
        final Container container = tester.widget<Container>(
          containerFinder.at(i),
        );
        if (container.decoration != null) {
          foundDecoratedContainer = true;
          final BoxDecoration decoration =
              container.decoration as BoxDecoration;
          expect(decoration.borderRadius, isA<BorderRadius>());
          final BorderRadius borderRadius =
              decoration.borderRadius as BorderRadius;
          expect(borderRadius.topLeft.x, equals(testBorderRadius));
          expect(borderRadius.bottomLeft.x, equals(testBorderRadius));
          break;
        }
      }
      expect(
        foundDecoratedContainer,
        isTrue,
        reason: 'Aucun container avec décoration trouvé',
      );
    });
  });
}
