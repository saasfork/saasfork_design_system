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

  static EdgeInsets getButtonPadding(ComponentSize size) {
    switch (size) {
      case ComponentSize.xs:
        return const EdgeInsets.all(4);
      case ComponentSize.sm:
        return const EdgeInsets.all(6);
      case ComponentSize.md:
        return const EdgeInsets.all(8);
      case ComponentSize.lg:
        return const EdgeInsets.all(10);
      case ComponentSize.xl:
        return const EdgeInsets.all(12);
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

  /// Retourne le padding pour les boutons circulaires selon la taille du composant
  static double getCircularButtonPadding(ComponentSize size) {
    switch (size) {
      case ComponentSize.xs:
        return 4.0;
      case ComponentSize.sm:
        return 6.0;
      case ComponentSize.md:
        return 8.0;
      case ComponentSize.lg:
        return 12.0;
      case ComponentSize.xl:
        return 16.0;
    }
  }

  static double getRadius(ComponentSize size) {
    switch (size) {
      case ComponentSize.xs:
        return 4.0;
      case ComponentSize.sm:
        return 6.0;
      case ComponentSize.md:
        return 8.0;
      case ComponentSize.lg:
        return 10.0;
      case ComponentSize.xl:
        return 12.0;
    }
  }

  static Size getButtonSize(ComponentSize size) {
    switch (size) {
      case ComponentSize.xs:
        return const Size(16, 16);
      case ComponentSize.sm:
        return const Size(32, 32);
      case ComponentSize.md:
        return const Size(36, 36);
      case ComponentSize.lg:
        return const Size(40, 40);
      case ComponentSize.xl:
        return const Size(48, 48);
    }
  }
}
