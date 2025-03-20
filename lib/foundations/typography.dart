import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/sizes.dart';

class AppTypography {
  // Styles d'affichage - pour les grands titres en tête de page
  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.25,
    height: 1.2,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  // Styles de titres - pour les sections et sous-sections
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  // Styles de titres d'éléments - pour les cartes, panneaux
  static const TextStyle titleLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.1,
  );

  // Styles de corps de texte - pour les paragraphes principaux
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.5,
    letterSpacing: 0.4,
  );

  // Styles d'étiquettes - pour les boutons, badges, champs de formulaire
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.1,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
  );

  /// Ajuste un style de texte en fonction de la taille du composant
  static TextStyle getScaledStyle(TextStyle baseStyle, ComponentSize size) {
    final scaleFactor = _getFontScaleFactor(size);
    return baseStyle.copyWith(
      fontSize:
          baseStyle.fontSize != null ? baseStyle.fontSize! * scaleFactor : null,
    );
  }

  /// Facteurs d'échelle pour les polices selon la taille du composant
  static double _getFontScaleFactor(ComponentSize size) {
    switch (size) {
      case ComponentSize.xs:
        return 0.8;
      case ComponentSize.sm:
        return 0.9;
      case ComponentSize.md:
        return 1.0;
      case ComponentSize.lg:
        return 1.2;
      case ComponentSize.xl:
        return 1.4;
    }
  }
}
