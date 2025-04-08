import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/organisms/marketing/widgets/heading_annoncement.dart';

void main() {
  group('SFHeadingAnnouncement', () {
    testWidgets('renders label correctly', (WidgetTester tester) async {
      const label = 'Test Label';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(child: SFHeadingAnnouncement(label: label)),
          ),
        ),
      );

      // Chercher directement le widget Text avec le contenu "Test Label" avec un espace
      expect(find.text('$label '), findsOneWidget);
    });

    testWidgets('renders ctaLabel when provided', (WidgetTester tester) async {
      const label = 'Test Label';
      const ctaLabel = 'Click Me';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SFHeadingAnnouncement(label: label, ctaLabel: ctaLabel),
            ),
          ),
        ),
      );

      expect(find.text(ctaLabel), findsOneWidget);
    });

    testWidgets('triggers onPressed callback when tapped', (
      WidgetTester tester,
    ) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SFHeadingAnnouncement(
                label: 'Test Label',
                onPressed: () {
                  wasPressed = true;
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SFHeadingAnnouncement));
      expect(wasPressed, isTrue);
    });

    testWidgets('applies custom colorSeeMore when provided', (
      WidgetTester tester,
    ) async {
      const label = 'Test Label';
      const ctaLabel = 'Click Me';
      const customColor = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SFHeadingAnnouncement(
                label: label,
                ctaLabel: ctaLabel,
                colorSeeMore: customColor,
              ),
            ),
          ),
        ),
      );

      // Trouver le widget Text qui contient le label CTA
      final textWidget = find.text(ctaLabel);
      expect(textWidget, findsOneWidget);

      // Vérifier que ce widget Text a la couleur personnalisée
      final text = tester.widget<Text>(textWidget);
      expect(text.style?.color, customColor);
    });
  });
}
