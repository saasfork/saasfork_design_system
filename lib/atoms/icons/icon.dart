import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/foundations.dart';

enum SFIconType { transparent, rounded, square }

/// Icône stylisée conforme au design system.
///
/// Propose trois styles d'affichage:
/// - [IconType.transparent]: Icône simple sans fond
/// - [IconType.rounded]: Icône avec fond circulaire teinté
/// - [IconType.square]: Icône avec fond carré arrondi teinté
///
/// Exemple:
/// ```dart
/// SFIcon(
///   icon: Icons.check,
///   color: AppColors.success,
///   iconType: IconType.rounded,
/// )
/// ```
class SFIcon extends StatelessWidget {
  /// Données de l'icône à afficher
  final IconData icon;

  /// Taille de base de l'icône (ajustée par [factorSize])
  final ComponentSize size;

  /// Couleur de l'icône (utilise la couleur primaire du thème par défaut)
  final Color? color;

  /// Style d'affichage de l'icône
  final SFIconType iconType;

  /// Padding autour de l'icône pour les styles avec fond
  final ComponentSize? padding;

  /// Facteur multiplicateur pour ajuster la taille de l'icône
  /// (par exemple, 1.2 agrandit l'icône de 20%)
  final double factorSize;

  const SFIcon({
    super.key,
    this.icon = Icons.star,
    this.size = ComponentSize.md,
    this.factorSize = 1.2,
    this.color,
    this.iconType = SFIconType.transparent,
    this.padding = ComponentSize.md,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = AppSizes.getIconSize(size) * factorSize;
    final themeColor = Theme.of(context).primaryColor;
    final iconColor = color ?? themeColor;
    final containerPadding = AppSizes.getPadding(padding!);

    switch (iconType) {
      case SFIconType.rounded:
        final containerSize = iconSize + (containerPadding.horizontal / 2);
        return Container(
          width: containerSize,
          height: containerSize,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Center(child: Icon(icon, size: iconSize, color: iconColor)),
        );
      case SFIconType.square:
        return Container(
          padding: containerPadding / factorSize,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: iconSize, color: iconColor),
        );
      case SFIconType.transparent:
        return Icon(icon, size: iconSize, color: iconColor);
      // ignore: unreachable_switch_default
      default:
        // Pour compatibilité future avec de nouveaux types
        return Icon(icon, size: iconSize, color: iconColor);
    }
  }
}
