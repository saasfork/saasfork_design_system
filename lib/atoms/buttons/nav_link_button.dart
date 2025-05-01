import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFNavLink {
  final String label;
  final bool isActive;
  final VoidCallback onPress;
  final IconData? icon;

  const SFNavLink({
    required this.label,
    required this.onPress,
    this.isActive = false,
    this.icon,
  });
}

class SFNavLinkItem extends StatelessWidget {
  final SFNavLink link;
  final bool fullWidth; // Nouveau paramètre pour contrôler la largeur

  const SFNavLinkItem({
    super.key,
    required this.link,
    this.fullWidth = false, // Par défaut, garder le comportement actuel
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final Color textColor =
        link.isActive
            ? (isDarkMode ? AppColors.grey.s50 : AppColors.grey.s600)
            : (isDarkMode ? AppColors.grey.s300 : AppColors.grey.s600);

    final Color bgColor =
        link.isActive
            ? (isDarkMode ? AppColors.grey.s700 : AppColors.grey.s50)
            : Colors.transparent;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: link.onPress,
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        child: Container(
          width:
              fullWidth
                  ? double.infinity
                  : null, // Utiliser toute la largeur si demandé
          padding: AppSizes.getPadding(ComponentSize.sm),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppSpacing.sm),
          ),
          child: Row(
            mainAxisSize:
                fullWidth
                    ? MainAxisSize.max
                    : MainAxisSize.min, // Ajuster selon le mode
            spacing: AppSpacing.xs,
            children: [
              if (link.icon != null) ...[
                Icon(link.icon, color: textColor, size: 20),
              ],
              Text(
                link.label,
                style: AppTypography.labelLarge.copyWith(color: textColor),
              ),
              // Ajouter un Spacer conditionnel pour "pousser" le texte vers la gauche en mode pleine largeur
              if (fullWidth) Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
