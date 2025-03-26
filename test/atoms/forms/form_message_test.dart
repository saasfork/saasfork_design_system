import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/atoms/forms/form_message.dart';
import 'package:saasfork_design_system/foundations/colors.dart';

void main() {
  testWidgets('SFFormMessage displays hint message when no error', (
    WidgetTester tester,
  ) async {
    // Arrangement
    const hintMessage = 'Enter your email address';

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: SFFormMessage(hintMessage: hintMessage)),
      ),
    );

    // Assert
    expect(find.text(hintMessage), findsOneWidget);
    final textWidget = tester.widget<Text>(find.text(hintMessage));
    expect(textWidget.style?.color, equals(AppColors.gray.s400));
    expect(textWidget.style?.fontStyle, equals(FontStyle.italic));
  });

  testWidgets('SFFormMessage displays error message when provided', (
    WidgetTester tester,
  ) async {
    // Arrangement
    const hintMessage = 'Enter your email address';
    const errorMessage = 'Email is invalid';

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SFFormMessage(
            hintMessage: hintMessage,
            errorMessage: errorMessage,
          ),
        ),
      ),
    );

    // Assert
    expect(find.text(errorMessage), findsOneWidget);
    expect(find.text(hintMessage), findsNothing);
    final textWidget = tester.widget<Text>(find.text(errorMessage));
    expect(textWidget.style?.color, equals(AppColors.red.s400));
    expect(textWidget.style?.fontStyle, equals(FontStyle.italic));
  });

  testWidgets('SFFormMessage displays empty string when no message provided', (
    WidgetTester tester,
  ) async {
    // Act
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: SFFormMessage())),
    );

    // Assert
    expect(find.text(''), findsOneWidget);
    final textWidget = tester.widget<Text>(find.text(''));
    expect(textWidget.style?.color, equals(AppColors.gray.s400));
    expect(textWidget.style?.fontStyle, equals(FontStyle.italic));
  });

  testWidgets('SFFormMessage ignores empty error message', (
    WidgetTester tester,
  ) async {
    // Arrangement
    const hintMessage = 'Enter your email address';
    const errorMessage = '';

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SFFormMessage(
            hintMessage: hintMessage,
            errorMessage: errorMessage,
          ),
        ),
      ),
    );

    // Assert
    expect(find.text(hintMessage), findsOneWidget);
    expect(find.text(errorMessage), findsNothing);
  });
}
