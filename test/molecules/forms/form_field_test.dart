import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/atoms/forms/form_message.dart';
import 'package:saasfork_design_system/foundations/colors.dart';
import 'package:saasfork_design_system/molecules/forms/form_field.dart';

void main() {
  testWidgets('SFFormfield displays label, input and hint correctly', (
    WidgetTester tester,
  ) async {
    // Arrangement
    const label = 'Email';
    const hintMessage = 'Enter your email address';
    final input = TextFormField(
      decoration: const InputDecoration(border: OutlineInputBorder()),
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SFFormfield(
            label: label,
            input: input,
            hintMessage: hintMessage,
          ),
        ),
      ),
    );

    // Assert
    expect(find.text(label), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.text(hintMessage), findsOneWidget);
  });

  testWidgets('SFFormfield displays error message when provided', (
    WidgetTester tester,
  ) async {
    // Arrangement
    const label = 'Email';
    const errorMessage = 'Email is invalid';
    final input = TextFormField(
      decoration: const InputDecoration(border: OutlineInputBorder()),
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SFFormfield(
            label: label,
            input: input,
            errorMessage: errorMessage,
          ),
        ),
      ),
    );

    // Assert
    expect(find.text(label), findsOneWidget);
    expect(find.text(errorMessage), findsOneWidget);

    // Error text should be red
    final errorText = tester.widget<Text>(find.text(errorMessage));
    expect(errorText.style?.color, equals(AppColors.red.s400));

    // Label should also be red when there's an error
    final labelText = tester.widget<Text>(find.text(label));
    expect(labelText.style?.color, equals(AppColors.red.s400));
  });

  testWidgets(
    'SFFormfield displays required asterisk when isRequired is true',
    (WidgetTester tester) async {
      // Arrangement
      const label = 'Email';
      final input = TextFormField(
        decoration: const InputDecoration(border: OutlineInputBorder()),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFFormfield(label: label, input: input, isRequired: true),
          ),
        ),
      );

      // Assert
      expect(find.text('$label *'), findsOneWidget);
    },
  );

  testWidgets('SFFormfield prioritizes error message over hint message', (
    WidgetTester tester,
  ) async {
    // Arrangement
    const label = 'Email';
    const hintMessage = 'Enter your email address';
    const errorMessage = 'Email is invalid';
    final input = TextFormField(
      decoration: const InputDecoration(border: OutlineInputBorder()),
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SFFormfield(
            label: label,
            input: input,
            hintMessage: hintMessage,
            errorMessage: errorMessage,
          ),
        ),
      ),
    );

    // Assert
    expect(find.text(errorMessage), findsOneWidget);
    expect(find.text(hintMessage), findsNothing);
  });

  testWidgets(
    'SFFormfield displays empty string when no hint or error is provided',
    (WidgetTester tester) async {
      // Arrangement
      const label = 'Email';
      final input = TextFormField(
        decoration: const InputDecoration(border: OutlineInputBorder()),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SFFormfield(label: label, input: input)),
        ),
      );

      // Assert
      // Trouver le widget SFFormMessage qui est destiné à afficher le hint/error
      // (le dernier élément du SFFormfield)
      final formField = find.byType(SFFormfield);
      final column = tester.widget<Column>(
        find.descendant(of: formField, matching: find.byType(Column)),
      );

      // Le dernier widget dans la colonne devrait être SFFormMessage
      final lastWidget = column.children.last;
      expect(lastWidget, isA<SFFormMessage>());

      // Vérifier qu'aucun texte n'est affiché dans le SFFormMessage
      final formMessageWidget = find.descendant(
        of: formField,
        matching: find.byType(SFFormMessage),
      );

      // Si SFFormMessage contient un Text widget à l'intérieur, nous pouvons vérifier
      // qu'il n'y a pas de texte visible ou que le texte est vide
      expect(
        find.descendant(of: formMessageWidget, matching: find.text('')),
        findsOneWidget,
      );
    },
  );

  testWidgets('SFFormfield does not display label when it is null', (
    WidgetTester tester,
  ) async {
    // Arrangement
    final input = TextFormField(
      decoration: const InputDecoration(border: OutlineInputBorder()),
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: SFFormfield(label: null, input: input))),
    );

    // Assert
    final formField = find.byType(SFFormfield);
    final column = tester.widget<Column>(
      find.descendant(of: formField, matching: find.byType(Column)),
    );

    // Le premier widget dans la colonne ne devrait pas être un Text (label)
    expect(column.children.first, isNot(isA<Text>()));

    // Vérifier que seuls les widgets input et SFFormMessage sont présents
    expect(column.children.length, 2);
    expect(column.children.first, isA<TextFormField>());
    expect(column.children.last, isA<SFFormMessage>());
  });

  testWidgets('SFFormfield does not display label when it is empty', (
    WidgetTester tester,
  ) async {
    // Arrangement
    final input = TextFormField(
      decoration: const InputDecoration(border: OutlineInputBorder()),
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: SFFormfield(label: '', input: input))),
    );

    // Assert
    final formField = find.byType(SFFormfield);
    final column = tester.widget<Column>(
      find.descendant(of: formField, matching: find.byType(Column)),
    );

    // Le premier widget dans la colonne ne devrait pas être un Text (label)
    expect(column.children.first, isNot(isA<Text>()));

    // Vérifier que seuls les widgets input et SFFormMessage sont présents
    expect(column.children.length, 2);
    expect(column.children.first, isA<TextFormField>());
    expect(column.children.last, isA<SFFormMessage>());
  });
}
