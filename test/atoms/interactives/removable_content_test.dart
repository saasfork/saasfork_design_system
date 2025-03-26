import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/atoms/interactives/removable_content.dart';

void main() {
  testWidgets('RemovableContent affiche l\'enfant', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RemovableContent(
            onPress: () {},
            child: const Text('Test Content'),
          ),
        ),
      ),
    );

    expect(find.text('Test Content'), findsOneWidget);
  });

  testWidgets(
    'RemovableContent affiche le bouton de suppression quand onPress est fourni',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RemovableContent(
              onPress: () {},
              child: const Text('Test Content'),
            ),
          ),
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    },
  );

  testWidgets(
    'RemovableContent ne montre pas le bouton quand disabled est true',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RemovableContent(
              onPress: () {},
              disabled: true,
              child: const Text('Test Content'),
            ),
          ),
        ),
      );

      expect(find.byType(InkWell), findsNothing);
      expect(find.byIcon(Icons.close), findsNothing);
    },
  );

  testWidgets(
    'RemovableContent ne montre pas le bouton quand onPress est null',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RemovableContent(
              onPress: null,
              child: const Text('Test Content'),
            ),
          ),
        ),
      );

      expect(find.byType(InkWell), findsNothing);
      expect(find.byIcon(Icons.close), findsNothing);
    },
  );

  testWidgets('RemovableContent appelle onPress quand le bouton est tapé', (
    WidgetTester tester,
  ) async {
    bool wasCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RemovableContent(
            onPress: () {
              wasCalled = true;
            },
            child: const Text('Test Content'),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(InkWell));
    expect(wasCalled, isTrue);
  });

  testWidgets('RemovableContent permet de personnaliser l\'icône', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RemovableContent(
            onPress: () {},
            icon: Icons.delete,
            child: const Text('Test Content'),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.delete), findsOneWidget);
    expect(find.byIcon(Icons.close), findsNothing);
  });

  testWidgets('RemovableContent permet de personnaliser la taille du bouton', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RemovableContent(
            onPress: () {},
            buttonSize: 36.0,
            child: const Text('Test Content'),
          ),
        ),
      ),
    );

    final Container container = tester.widget<Container>(
      find.byType(Container),
    );
    expect(container.constraints?.constrainWidth(), 36.0);
    expect(container.constraints?.constrainHeight(), 36.0);
  });

  testWidgets('RemovableContent permet de personnaliser les couleurs', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RemovableContent(
            onPress: () {},
            buttonColor: Colors.blue,
            iconColor: Colors.yellow,
            child: const Text('Test Content'),
          ),
        ),
      ),
    );

    final Container container = tester.widget<Container>(
      find.byType(Container),
    );
    final BoxDecoration decoration = container.decoration as BoxDecoration;
    expect(decoration.color, Colors.blue);

    final Icon icon = tester.widget<Icon>(find.byType(Icon));
    expect(icon.color, Colors.yellow);
  });
}
