import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/molecules/molecules.dart';
import 'package:saasfork_design_system/utils/services/notifications/adapter_registry.dart';
import 'package:saasfork_design_system/utils/services/notifications/adapters/notification_adapter.dart';

void main() {
  group('SFNotificationAdapter', () {
    test('canHandle retourne true pour SFNotification', () {
      final adapter = SFNotificationAdapter();
      final notification = SFNotification(
        message: 'Test',
        iconColor: Colors.blue,
      );

      expect(adapter.canHandle(notification), isTrue);
    });

    test('canHandle retourne false pour d\'autres widgets', () {
      final adapter = SFNotificationAdapter();
      final notification = Text('Not a notification');

      expect(adapter.canHandle(notification), isFalse);
    });

    test(
      'adaptNotification connecte correctement le callback de fermeture',
      () {
        final adapter = SFNotificationAdapter();
        bool originalCallbackCalled = false;
        bool closeCallbackCalled = false;

        final notification = SFNotification(
          message: 'Test',
          iconColor: Colors.blue,
          onClose: () => originalCallbackCalled = true,
        );

        final adapted =
            adapter.adaptNotification(
                  notification,
                  () => closeCallbackCalled = true,
                )
                as SFNotification;

        // Exécuter le callback de fermeture
        adapted.onClose!();

        // Vérifier que les deux callbacks ont été appelés
        expect(originalCallbackCalled, isTrue);
        expect(closeCallbackCalled, isTrue);
      },
    );
  });

  group('NotificationAdapterRegistry', () {
    test('registerAdapter ajoute un adaptateur au registre', () {
      final registry = NotificationAdapterRegistry();
      final adapter = SFNotificationAdapter();

      registry.registerAdapter(adapter);

      final notification = SFNotification(
        message: 'Test',
        iconColor: Colors.blue,
      );

      // L'adaptateur doit être trouvé pour SFNotification
      expect(registry.findAdapterFor(notification), isNotNull);
    });

    test('adaptNotification utilise l\'adaptateur approprié', () {
      final registry = NotificationAdapterRegistry();
      registry.registerAdapter(SFNotificationAdapter());

      bool closeCallbackCalled = false;

      final notification = SFNotification(
        message: 'Test',
        iconColor: Colors.blue,
      );

      final adapted =
          registry.adaptNotification(
                notification,
                () => closeCallbackCalled = true,
              )
              as SFNotification;

      // Vérifier que l'adaptation a eu lieu
      expect(adapted.onClose, isNotNull);

      // Exécuter le callback
      adapted.onClose!();
      expect(closeCallbackCalled, isTrue);
    });
  });
}
