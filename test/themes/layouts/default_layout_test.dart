import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/themes/layouts/default_layout.dart';
import 'package:saasfork_design_system/themes/layouts/layout_builder.dart';
import 'package:saasfork_design_system/themes/wrappers/notification_wrapper.dart';

void main() {
  group('SFDefaultLayout', () {
    testWidgets('renders with content only', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: SFDefaultLayout(
              builder: SFLayoutBuilder(
                contentBuilder: (context, ref) => const Text('Content'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
      expect(find.byType(AppBar), findsNothing);
      expect(find.byType(Drawer), findsNothing);
    });

    testWidgets('renders with header', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: SFDefaultLayout(
              builder: SFLayoutBuilder(
                contentBuilder: (context, ref) => const Text('Content'),
                headerBuilder:
                    (context, ref) => AppBar(title: const Text('Header')),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
      expect(find.text('Header'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Drawer), findsNothing);
    });

    testWidgets('renders with drawer', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Builder(
              builder:
                  (context) => SFDefaultLayout(
                    builder: SFLayoutBuilder(
                      contentBuilder: (context, ref) => const Text('Content'),
                      drawerBuilder:
                          (context, ref) =>
                              ListView(children: const [Text('Drawer Item')]),
                    ),
                  ),
            ),
          ),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
      expect(find.byType(AppBar), findsNothing);

      // Vérifier que le bouton de menu du drawer est rendu
      final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));
      expect(scaffoldState.hasDrawer, isTrue);

      // Ouvrir le drawer en utilisant l'API Scaffold au lieu de simuler un geste
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      // Maintenant on peut vérifier que le contenu du drawer est visible
      expect(find.text('Drawer Item'), findsOneWidget);
    });

    testWidgets('renders with footer', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: SFDefaultLayout(
              builder: SFLayoutBuilder(
                contentBuilder: (context, ref) => const Text('Content'),
                footerBuilder:
                    (context, ref) => Container(
                      color: Colors.blue,
                      height: 50,
                      child: const Center(child: Text('Footer')),
                    ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
      expect(find.text('Footer'), findsOneWidget);
      expect(find.byType(AppBar), findsNothing);
      expect(find.byType(Drawer), findsNothing);
    });

    testWidgets('layout is wrapped with NotificationWrapper', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: SFDefaultLayout(
              builder: SFLayoutBuilder(
                contentBuilder: (context, ref) => const Text('Content'),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(NotificationWrapper), findsOneWidget);
    });

    testWidgets('renders with all elements', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Builder(
              builder:
                  (context) => SFDefaultLayout(
                    builder: SFLayoutBuilder(
                      contentBuilder: (context, ref) => const Text('Content'),
                      headerBuilder:
                          (context, ref) => AppBar(title: const Text('Header')),
                      drawerBuilder:
                          (context, ref) =>
                              ListView(children: const [Text('Drawer Item')]),
                      footerBuilder:
                          (context, ref) => Container(
                            color: Colors.blue,
                            height: 50,
                            child: const Center(child: Text('Footer')),
                          ),
                    ),
                  ),
            ),
          ),
        ),
      );

      expect(find.text('Content'), findsOneWidget);
      expect(find.text('Header'), findsOneWidget);
      expect(find.text('Footer'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);

      // Vérifier que le Scaffold a un drawer
      final ScaffoldState scaffoldState = tester.state(find.byType(Scaffold));
      expect(scaffoldState.hasDrawer, isTrue);
    });
  });
}
