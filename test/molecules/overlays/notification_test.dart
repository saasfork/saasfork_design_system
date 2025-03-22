import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/molecules/overlays/notification.dart';

void main() {
  group('SFNotification', () {
    testWidgets('renders with required message and iconColor', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFNotification(
              message: 'Test message',
              iconColor: Colors.green,
            ),
          ),
        ),
      );

      expect(find.text('Test message'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('renders with title when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFNotification(
              title: 'Test title',
              message: 'Test message',
              iconColor: Colors.red,
            ),
          ),
        ),
      );

      expect(find.text('Test title'), findsOneWidget);
      expect(find.text('Test message'), findsOneWidget);
    });

    testWidgets('renders with custom icon when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFNotification(
              message: 'Test message',
              icon: Icons.warning,
              iconColor: Colors.orange,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.warning), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsNothing);
    });

    testWidgets('calls onClose callback when close button is pressed', (
      WidgetTester tester,
    ) async {
      bool closeCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFNotification(
              message: 'Test message',
              iconColor: Colors.blue,
              onClose: () {
                closeCalled = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.close));
      await tester.pump();

      expect(closeCalled, isTrue);
    });

    testWidgets('asserts when message is empty', (WidgetTester tester) async {
      // Pour tester une assertion, nous devons utiliser FlutterError.onError dans un widget de test
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext context) {
              // Cette construction devrait déclencher l'assertion
              expect(() {
                return SFNotification(
                  message: '',
                  iconColor: Colors.green,
                ).build(context); // Appel explicite à build() avec un contexte
              }, throwsA(isA<AssertionError>()));

              // Renvoyer un widget par défaut pour que la construction soit valide
              return const Placeholder();
            },
          ),
        ),
      );
    });
  });
}
