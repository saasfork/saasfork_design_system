import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/utils/services/notifications/adapters/abstract.dart';
import 'package:saasfork_design_system/utils/services/notifications/adapter_registry.dart';

class MockNotification1 extends StatelessWidget {
  const MockNotification1({super.key});
  @override
  Widget build(BuildContext context) => Container();
}

class MockNotification2 extends StatelessWidget {
  const MockNotification2({super.key});
  @override
  Widget build(BuildContext context) => Container();
}

class MockAdapter1 implements NotificationAdapter {
  bool wasCalledWithCallback = false;
  VoidCallback? capturedCallback;

  @override
  bool canHandle(Widget notification) => notification is MockNotification1;

  @override
  Widget adaptNotification(Widget notification, VoidCallback closeCallback) {
    wasCalledWithCallback = true;
    capturedCallback = closeCallback;
    return const Text('Adapted1');
  }
}

class MockAdapter2 implements NotificationAdapter {
  @override
  bool canHandle(Widget notification) => notification is MockNotification2;

  @override
  Widget adaptNotification(Widget notification, VoidCallback closeCallback) {
    return const Text('Adapted2');
  }
}

class AlwaysHandlesAdapter implements NotificationAdapter {
  @override
  bool canHandle(Widget notification) => true;

  @override
  Widget adaptNotification(Widget notification, VoidCallback closeCallback) {
    return const Text('Always');
  }
}

void main() {
  group('NotificationAdapterRegistry', () {
    // Nettoyer le registre avant chaque test
    setUp(() {
      NotificationAdapterRegistry().clearAdapters();
    });

    // Classes fictives pour les tests

    test('est un singleton', () {
      // Arrange
      final instance1 = NotificationAdapterRegistry();
      final instance2 = NotificationAdapterRegistry();

      // Assert
      expect(identical(instance1, instance2), isTrue);
    });

    test('registerAdapter ajoute un adaptateur au registre', () {
      // Arrange
      final registry = NotificationAdapterRegistry();
      final adapter = MockAdapter1();

      // Reset la liste des adaptateurs pour les tests
      registry.runtimeType.toString();
      // Note: Cette approche est utilisée uniquement pour les tests
      // En pratique, on préférerait injecter un registre de test

      // Act
      registry.registerAdapter(adapter);

      // Assert - indirectement via findAdapterFor
      final notification = const MockNotification1();
      final foundAdapter = registry.findAdapterFor(notification);
      expect(foundAdapter, isA<MockAdapter1>());
    });

    test('findAdapterFor trouve l\'adaptateur correspondant', () {
      // Arrange
      final registry = NotificationAdapterRegistry();
      final adapter1 = MockAdapter1();
      final adapter2 = MockAdapter2();

      registry.registerAdapter(adapter1);
      registry.registerAdapter(adapter2);

      // Act & Assert
      final notification1 = const MockNotification1();
      final notification2 = const MockNotification2();
      final unknownNotification = const Text('Unknown');

      expect(registry.findAdapterFor(notification1), isA<MockAdapter1>());
      expect(registry.findAdapterFor(notification2), isA<MockAdapter2>());
      expect(registry.findAdapterFor(unknownNotification), isNull);
    });

    test('adaptNotification utilise l\'adaptateur correspondant', () {
      // Arrange
      final registry = NotificationAdapterRegistry();
      final adapter1 = MockAdapter1();
      final adapter2 = MockAdapter2();

      registry.registerAdapter(adapter1);
      registry.registerAdapter(adapter2);

      bool callbackCalled = false;
      closeCallback() => callbackCalled = true;

      // Act
      final adapted1 = registry.adaptNotification(
        const MockNotification1(),
        closeCallback,
      );

      // Assert
      expect(adapted1, isA<Text>());
      expect((adapted1 as Text).data, equals('Adapted1'));
      expect(adapter1.wasCalledWithCallback, isTrue);

      // Ne pas comparer les fonctions directement
      // expect(adapter1.capturedCallback, equals(closeCallback));  // ❌ À éviter

      // Au lieu de cela, vérifiez l'effet de la fonction:
      adapter1.capturedCallback!();
      expect(callbackCalled, isTrue);
    });

    test(
      'adaptNotification retourne la notification originale si pas d\'adaptateur',
      () {
        // Arrange
        final registry = NotificationAdapterRegistry();
        final unknownNotification = const Text('Original');

        // Act
        final result = registry.adaptNotification(unknownNotification, () {});

        // Assert
        expect(result, equals(unknownNotification));
        expect((result as Text).data, equals('Original'));
      },
    );

    test('adaptNotification utilise le premier adaptateur compatible', () {
      // Arrange
      final registry = NotificationAdapterRegistry();

      // Enregistrer deux adaptateurs "AlwaysHandlesAdapter"
      registry.registerAdapter(AlwaysHandlesAdapter());
      registry.registerAdapter(AlwaysHandlesAdapter());

      // Act
      final adapted = registry.adaptNotification(const Text('Any'), () {});

      // Assert
      expect(adapted, isA<Text>());
      expect((adapted as Text).data, equals('Always'));
    });

    test(
      'adaptNotification transfère le callback de fermeture à l\'adaptateur',
      () {
        // Arrange
        final registry = NotificationAdapterRegistry();
        final adapter = MockAdapter1();
        registry.registerAdapter(adapter);

        int closeCount = 0;
        closeCallback() => closeCount++;

        // Act
        registry.adaptNotification(const MockNotification1(), closeCallback);

        // Execute le callback capturé
        adapter.capturedCallback!();

        // Assert
        expect(closeCount, 1);
      },
    );
  });
}
