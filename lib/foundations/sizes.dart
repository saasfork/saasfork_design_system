import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/spacing.dart';

/// Tailles standardisées pour les composants de l'interface utilisateur
enum ComponentSize { xs, sm, md, lg, xl }

/// Classe utilitaire pour gérer les dimensions basées sur les tailles standardisées
class AppSizes {
  /// Convertit une taille de composant en EdgeInsets pour le padding
  static EdgeInsets getPadding(ComponentSize size) {
    switch (size) {
      case ComponentSize.xs:
        return const EdgeInsets.symmetric(
          vertical: AppSpacing.xs,
          horizontal: AppSpacing.sm,
        );
      case ComponentSize.sm:
        return const EdgeInsets.symmetric(
          vertical: AppSpacing.sm,
          horizontal: AppSpacing.md,
        );
      case ComponentSize.md:
        return const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
          horizontal: AppSpacing.lg,
        );
      case ComponentSize.lg:
        return const EdgeInsets.symmetric(
          vertical: AppSpacing.lg,
          horizontal: AppSpacing.xl,
        );
      case ComponentSize.xl:
        return const EdgeInsets.symmetric(
          vertical: AppSpacing.xl,
          horizontal: AppSpacing.xxl,
        );
    }
  }

  /// Convertit une taille de composant en EdgeInsets pour le padding des inputs
  static EdgeInsets getInputPadding(ComponentSize size) {
    switch (size) {
      case ComponentSize.xs:
        return const EdgeInsets.symmetric(
          vertical: AppSpacing.xs,
          horizontal: AppSpacing.sm,
        );
      case ComponentSize.sm:
        return const EdgeInsets.symmetric(
          vertical: AppSpacing.sm - 2,
          horizontal: AppSpacing.md,
        );
      case ComponentSize.md:
        return const EdgeInsets.symmetric(
          vertical: AppSpacing.md - 6,
          horizontal: AppSpacing.lg,
        );
      case ComponentSize.lg:
        return const EdgeInsets.symmetric(
          vertical: AppSpacing.lg - 8,
          horizontal: AppSpacing.xl,
        );
      case ComponentSize.xl:
        return const EdgeInsets.symmetric(
          vertical: AppSpacing.xl - 10,
          horizontal: AppSpacing.xxl,
        );
    }
  }

  /// Retourne les contraintes BoxConstraints pour les inputs selon leur taille
  static BoxConstraints getInputConstraints(ComponentSize size) {
    final padding = getInputPadding(size);

    switch (size) {
      case ComponentSize.xs:
        return BoxConstraints.tightFor(height: padding.vertical * 2 + 20);
      case ComponentSize.sm:
        return BoxConstraints.tightFor(height: padding.vertical * 2 + 22);
      case ComponentSize.md:
        return BoxConstraints.tightFor(height: padding.vertical * 2);
      case ComponentSize.lg:
        return BoxConstraints.tightFor(height: padding.vertical * 2 - 12);
      case ComponentSize.xl:
        return BoxConstraints.tightFor(height: padding.vertical * 2 - 14);
    }
  }

  /// Retourne la taille de l'icône selon la taille du composant
  static double getIconSize(ComponentSize size) {
    switch (size) {
      case ComponentSize.xs:
        return 12.0;
      case ComponentSize.sm:
        return 16.0;
      case ComponentSize.md:
        return 18.0;
      case ComponentSize.lg:
        return 20.0;
      case ComponentSize.xl:
        return 22.0;
    }
  }
}
