// notification_extension.dart
import 'package:flutter/material.dart';
import 'package:saasfork_design_system/molecules/overlays/notification.dart';
import 'package:saasfork_design_system/foundations/foundations.dart';
import 'package:saasfork_design_system/utils/services/notification_service.dart';

/// Extension qui permet d'afficher facilement des notifications
/// depuis n'importe quel contexte
extension NotificationExtension on BuildContext {
  /// Affiche une notification personnalisée
  ///
  /// Exemple d'utilisation:
  /// ```dart
  /// context.showNotification(
  ///   SFNotification(
  ///     title: 'Succès',
  ///     message: 'Opération réussie',
  ///     iconColor: AppColors.success,
  ///   ),
  /// );
  /// ```
  void showNotification(
    Widget notification, {
    Duration duration = const Duration(seconds: 4),
    EdgeInsets? margin,
    bool requireSafeArea = true,
  }) {
    NotificationService().showNotification(
      this,
      notification,
      duration: duration,
      margin: margin ?? const EdgeInsets.only(top: 16, right: 16),
      requireSafeArea: requireSafeArea,
    );
  }

  /// Affiche une notification de succès
  ///
  /// ```dart
  /// context.showSuccess(
  ///   title: 'Enregistré',
  ///   message: 'Vos modifications ont été enregistrées'
  /// );
  /// ```
  void showSuccess({
    String? title,
    required String message,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onClose,
  }) {
    showNotification(
      SFNotification(
        title: title ?? 'Succès',
        message: message,
        icon: Icons.check_circle_outline_rounded,
        iconColor: AppColors.success,
        onClose: onClose,
      ),
      duration: duration,
    );
  }

  /// Affiche une notification d'erreur
  ///
  /// ```dart
  /// context.showError(
  ///   title: 'Échec',
  ///   message: 'Impossible de se connecter au serveur'
  /// );
  /// ```
  void showError({
    String? title,
    required String message,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onClose,
  }) {
    showNotification(
      SFNotification(
        title: title ?? 'Erreur',
        message: message,
        icon: Icons.error_outline_rounded,
        iconColor: AppColors.danger,
        onClose: onClose,
      ),
      duration: duration,
    );
  }

  /// Affiche une notification d'information
  ///
  /// ```dart
  /// context.showInfo(
  ///   message: 'Une mise à jour est disponible'
  /// );
  /// ```
  void showInfo({
    String? title,
    required String message,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onClose,
  }) {
    showNotification(
      SFNotification(
        title: title ?? 'Information',
        message: message,
        icon: Icons.info_outline_rounded,
        iconColor: AppColors.info,
        onClose: onClose,
      ),
      duration: duration,
    );
  }

  /// Affiche une notification d'avertissement
  ///
  /// ```dart
  /// context.showWarning(
  ///   title: 'Attention',
  ///   message: 'Votre abonnement expire bientôt'
  /// );
  /// ```
  void showWarning({
    String? title,
    required String message,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onClose,
  }) {
    showNotification(
      SFNotification(
        title: title ?? 'Attention',
        message: message,
        icon: Icons.warning_amber_rounded,
        iconColor: AppColors.warning,
        onClose: onClose,
      ),
      duration: duration,
    );
  }

  /// Affiche une notification de confirmation
  ///
  /// ```dart
  /// context.showConfirmation(
  ///   message: 'Profil mis à jour avec succès'
  /// );
  /// ```
  void showConfirmation({
    String? title,
    required String message,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onClose,
  }) {
    showNotification(
      SFNotification(
        title: title ?? 'Confirmation',
        message: message,
        icon: Icons.check_circle_outline_rounded,
        iconColor: AppColors.indigo,
        onClose: onClose,
      ),
      duration: duration,
    );
  }
}
