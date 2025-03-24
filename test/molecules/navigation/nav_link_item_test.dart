import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

void main() {
  group('SFNavLinkItem', () {
    // Test pour vérifier le rendu de base avec un lien inactif
    testWidgets('renders inactive link correctly', (WidgetTester tester) async {
      bool wasPressed = false;

      final link = SFNavLink(
        label: 'Accueil',
        isActive: false,
        onPress: () => wasPressed = true,
      );

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: SFNavLinkItem(link: link))),
      );

      // Vérifier que le texte est affiché
      expect(find.text('Accueil'), findsOneWidget);

      // Vérifier que le style inactif est appliqué (couleur différente)
      final textWidget = tester.widget<Text>(find.text('Accueil'));
      expect(textWidget.style?.fontWeight, isNot(equals(FontWeight.bold)));

      // Cliquer sur le lien et vérifier que la fonction onPress est appelée
      await tester.tap(find.text('Accueil'));
      await tester.pumpAndSettle();
      expect(wasPressed, isTrue);
    });

    // Test pour vérifier le rendu avec un lien actif
    testWidgets('renders active link correctly', (WidgetTester tester) async {
      final link = SFNavLink(label: 'Accueil', isActive: true, onPress: () {});

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: SFNavLinkItem(link: link))),
      );

      // Vérifier que le style actif est appliqué (medium ou couleur différente)
      final textWidget = tester.widget<Text>(find.text('Accueil'));
      expect(textWidget.style?.fontWeight, equals(FontWeight.w500));

      // Vérifier s'il y a un indicateur visuel d'élément actif (comme un soulignement)
      // Cette vérification dépend de l'implémentation exacte, mais on peut vérifier
      // s'il y a un Container ou Decoration spécifique
      expect(
        find.ancestor(
          of: find.text('Accueil'),
          matching: find.byWidgetPredicate(
            (widget) => widget is Container && widget.decoration != null,
          ),
        ),
        findsOneWidget,
      );
    });

    // Test pour vérifier le comportement d'un lien avec icône
    testWidgets('renders link with icon correctly', (
      WidgetTester tester,
    ) async {
      final link = SFNavLink(
        label: 'Paramètres',
        isActive: false,
        onPress: () {},
        icon: Icons.settings,
      );

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: SFNavLinkItem(link: link))),
      );

      // Vérifier que le texte est affiché
      expect(find.text('Paramètres'), findsOneWidget);

      // Vérifier que l'icône est affichée
      expect(find.byIcon(Icons.settings), findsOneWidget);

      // Vérifier l'ordre : l'icône devrait être avant le texte
      final iconWidget = tester.widget<Icon>(find.byIcon(Icons.settings));
      final textWidget = tester.widget<Text>(find.text('Paramètres'));

      expect(
        tester.getTopLeft(find.byWidget(iconWidget)).dx <
            tester.getTopLeft(find.byWidget(textWidget)).dx,
        isTrue,
      );
    });

    // Test pour vérifier l'accessibilité
    testWidgets('has appropriate semantics for accessibility', (
      WidgetTester tester,
    ) async {
      final link = SFNavLink(label: 'Contact', isActive: false, onPress: () {});

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: SFNavLinkItem(link: link))),
      );

      // Vérifier que le widget a des données sémantiques appropriées
      expect(find.bySemanticsLabel('Contact'), findsOneWidget);
    });
  });
}
