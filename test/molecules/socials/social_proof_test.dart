import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

void main() {
  group('SFSocialProof', () {
    testWidgets('affiche correctement avec les paramètres requis', (
      WidgetTester tester,
    ) async {
      // Arrange
      const String textTest = 'Utilisé par plus de 1000 clients';
      final List<String> imageUrls = [
        'https://example.com/avatar1.jpg',
        'https://example.com/avatar2.jpg',
        'https://example.com/avatar3.jpg',
      ];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFSocialProof(imageUrls: imageUrls, text: textTest),
          ),
        ),
      );

      // Assert
      expect(find.text(textTest), findsOneWidget);
      expect(find.byType(SFImageCircle), findsNWidgets(imageUrls.length));
      expect(find.byType(SFSocialProof), findsOneWidget);
    });

    testWidgets('fonctionne correctement avec une liste vide d\'images', (
      WidgetTester tester,
    ) async {
      // Arrange
      const String textTest = 'Aucune image disponible';
      final List<String> imageUrls = [];

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFSocialProof(imageUrls: imageUrls, text: textTest),
          ),
        ),
      );

      // Assert
      expect(find.text(textTest), findsOneWidget);
      expect(find.byType(SFImageCircle), findsNothing);
    });

    testWidgets('respecte la taille d\'image personnalisée', (
      WidgetTester tester,
    ) async {
      // Arrange
      const String textTest = 'Images personnalisées';
      final List<String> imageUrls = [
        'https://example.com/avatar1.jpg',
        'https://example.com/avatar2.jpg',
      ];
      const double customSize = 60.0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFSocialProof(
              imageUrls: imageUrls,
              text: textTest,
              imageSize: customSize,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(textTest), findsOneWidget);
      expect(find.byType(SFImageCircle), findsNWidgets(imageUrls.length));
    });

    testWidgets('applique correctement l\'espacement', (
      WidgetTester tester,
    ) async {
      // Arrange
      const String textTest = 'Espacement personnalisé';
      final List<String> imageUrls = ['https://example.com/avatar1.jpg'];

      // Act - avec ComponentSize.sm
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFSocialProof(
              imageUrls: imageUrls,
              text: textTest,
              spacing: ComponentSize.sm,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(textTest), findsOneWidget);
      expect(find.byType(SFImageCircle), findsOneWidget);

      // Act - avec ComponentSize.lg
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFSocialProof(
              imageUrls: imageUrls,
              text: textTest,
              spacing: ComponentSize.lg,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(textTest), findsOneWidget);
      expect(find.byType(SFImageCircle), findsOneWidget);
    });

    testWidgets('respecte la largeur maximale', (WidgetTester tester) async {
      // Arrange
      const String textTest = 'Largeur maximale';
      final List<String> imageUrls = ['https://example.com/avatar1.jpg'];
      const double maxWidth = 300.0;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFSocialProof(
              imageUrls: imageUrls,
              text: textTest,
              maxWidth: maxWidth,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(textTest), findsOneWidget);
      expect(find.byType(SFSocialProof), findsOneWidget);

      final SFSocialProof socialProofWidget = tester.widget<SFSocialProof>(
        find.byType(SFSocialProof),
      );
      expect(socialProofWidget.maxWidth, equals(maxWidth));
    });
  });
}
