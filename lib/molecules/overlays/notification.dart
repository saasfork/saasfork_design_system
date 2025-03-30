import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/foundations.dart';

/// Un widget de notification qui affiche un message important à l'utilisateur.
///
/// Cette notification contient une icône, un titre optionnel, un message et un bouton de fermeture.
/// Elle est conçue pour être utilisée dans un contexte d'affichage temporaire d'informations
/// comme des succès, des erreurs, des avertissements ou des informations générales.
///
/// ## Paramètres
///
/// * [message] - Le texte principal de la notification (obligatoire).
/// * [iconColor] - La couleur de l'icône (obligatoire).
/// * [title] - Un titre optionnel qui apparaît au-dessus du message.
/// * [icon] - L'icône à afficher (par défaut: Icons.check_circle).
/// * [onClose] - Fonction appelée lorsque l'utilisateur ferme la notification.
///
/// ## Exemple d'utilisation
///
/// ```dart
/// // Notification de succès
/// SFNotification(
///   title: 'Succès',
///   message: 'Votre paiement a été traité avec succès.',
///   iconColor: Colors.green,
///   onClose: () => Navigator.of(context).pop(),
/// )
///
/// // Notification d'erreur
/// SFNotification(
///   title: 'Erreur',
///   message: 'Impossible de traiter votre paiement. Veuillez réessayer.',
///   icon: Icons.error,
///   iconColor: Colors.red,
///   onClose: () => Navigator.of(context).pop(),
/// )
///
/// // Notification d'information sans titre
/// SFNotification(
///   message: 'Vos modifications ont été enregistrées.',
///   icon: Icons.info,
///   iconColor: Colors.blue,
///   onClose: () => Navigator.of(context).pop(),
/// )
/// ```
class SFNotification extends StatelessWidget {
  final String? title;
  final String message;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onClose;

  const SFNotification({
    super.key,
    required this.message,
    required this.iconColor,
    this.title,
    this.icon = Icons.check_circle,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    assert(message.isNotEmpty, 'Message cannot be empty');

    return Card(
      child: Stack(
        children: [
          Positioned(
            top: AppSpacing.sm,
            right: AppSpacing.sm,
            child: IconButton(
              hoverColor: Colors.transparent,
              icon: Icon(
                Icons.close,
                size: AppSizes.getIconSize(ComponentSize.sm),
                color: AppColors.slate,
              ),
              onPressed: onClose,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppSpacing.xs,
                    right: AppSpacing.md,
                    left: AppSpacing.xs,
                  ),
                  child: Icon(icon, color: iconColor),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.xl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      spacing: AppSpacing.sm,
                      children: [
                        if (title != null && title!.isNotEmpty)
                          Text(
                            title!,
                            style: Theme.of(context).textTheme.titleMedium,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        Text(
                          message,
                          style: Theme.of(context).textTheme.labelLarge,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
