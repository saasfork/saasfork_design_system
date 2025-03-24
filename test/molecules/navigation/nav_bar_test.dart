import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/molecules/navigation/nav_bar_mobile.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

void main() {
  group('SFNavBar', () {
    testWidgets('affiche correctement la version desktop sur grand écran', (
      WidgetTester tester,
    ) async {
      // Simuler un écran de grande taille (desktop)
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.reset());

      final Widget leading = Text('Logo');
      final List<SFNavLink> links = [
        SFNavLink(label: 'Accueil', onPress: () {}),
        SFNavLink(label: 'À propos', onPress: () {}),
      ];
      final List<Widget> actions = [
        TextButton(onPressed: () {}, child: Text('Connexion')),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFNavBar(leading: leading, links: links, actions: actions),
          ),
        ),
      );

      // Vérifier que le leading est affiché (pas centré en mode desktop)
      expect(find.text('Logo'), findsOneWidget);

      // Vérifier que les liens sont affichés horizontalement
      expect(find.text('Accueil'), findsOneWidget);
      expect(find.text('À propos'), findsOneWidget);

      // Vérifier que les actions sont affichées
      expect(find.text('Connexion'), findsOneWidget);

      // Vérifier que le NavBarMobile n'est pas utilisé en mode desktop
      expect(find.byType(SFNavBarMobile), findsNothing);
    });

    testWidgets('affiche correctement la version mobile sur petit écran', (
      WidgetTester tester,
    ) async {
      // Simuler un écran de petite taille (mobile)
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.reset());

      final Widget leading = Text('Logo');
      final List<SFNavLink> links = [
        SFNavLink(label: 'Accueil', onPress: () {}),
        SFNavLink(label: 'À propos', onPress: () {}),
      ];
      final List<Widget> actions = [
        TextButton(onPressed: () {}, child: Text('Connexion')),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFNavBar(leading: leading, links: links, actions: actions),
          ),
        ),
      );

      // Vérifier que le leading est affiché et centré en mode mobile
      expect(find.text('Logo'), findsOneWidget);

      // Vérifier que le NavBarMobile est utilisé en mode mobile
      expect(find.byType(SFNavBarMobile), findsOneWidget);

      // Vérifier que les actions sont toujours affichées
      expect(find.text('Connexion'), findsOneWidget);
    });

    testWidgets('applique correctement les propriétés personnalisées', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFNavBar(
              height: 80.0,
              backgroundColor: Colors.amber,
              horizontalPadding: 24.0,
            ),
          ),
        ),
      );

      // Récupérer le Container principal
      final container = tester.widget<Container>(find.byType(Container).first);

      // Vérifier la hauteur personnalisée
      expect(container.constraints?.maxHeight, 80.0);

      // Vérifier la couleur de fond personnalisée
      expect(container.color, Colors.amber);

      // Vérifier le padding horizontal personnalisé
      final EdgeInsetsGeometry padding = container.padding as EdgeInsets;
      expect(
        (padding as EdgeInsets).horizontal,
        24.0 * 2,
      ); // Left et right = 24.0 chacun
    });

    testWidgets('gère correctement le cas sans leading', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFNavBar(
              actions: [TextButton(onPressed: () {}, child: Text('Action'))],
            ),
          ),
        ),
      );

      // Vérifier que le widget est rendu sans erreur
      expect(find.byType(SFNavBar), findsOneWidget);
    });

    testWidgets('gère correctement le cas sans liens', (
      WidgetTester tester,
    ) async {
      // Simuler un écran de grande taille (desktop)
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.reset());

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFNavBar(
              leading: Text('Logo'),
              links: [], // Liste vide
              actions: [TextButton(onPressed: () {}, child: Text('Action'))],
            ),
          ),
        ),
      );

      // Vérifier que le widget est rendu sans erreur
      expect(find.byType(SFNavBar), findsOneWidget);
      expect(find.text('Logo'), findsOneWidget);
      expect(find.text('Action'), findsOneWidget);
    });

    testWidgets('gère correctement le cas sans actions', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFNavBar(
              leading: Text('Logo'),
              links: [SFNavLink(label: 'Accueil', onPress: () {})],
              actions: [], // Liste vide
            ),
          ),
        ),
      );

      // Vérifier que le widget est rendu sans erreur
      expect(find.byType(SFNavBar), findsOneWidget);
      expect(find.text('Logo'), findsOneWidget);
    });
  });
}
