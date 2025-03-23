import 'package:flutter/material.dart';

/// Types d'écrans supportés
enum SFScreenSize {
  mobile, // < 600px
  tablet, // 600px - 900px
  desktop, // 900px - 1200px
  largeDesktop, // > 1200px
}

/// Configuration système pour la responsivité
class SFBreakpoints {
  /// Seuils de largeur pour chaque type d'écran
  static const double mobileBreakpoint = 0;
  static const double tabletBreakpoint = 600;
  static const double desktopBreakpoint = 900; // Garde votre valeur originale
  static const double largeDesktopBreakpoint =
      1200; // Garde votre valeur originale

  /// Nombre de colonnes par défaut pour chaque type d'écran
  /// IMPORTANT: On garde les valeurs originales pour préserver le comportement
  static const int mobileColumns =
      1; // Restauré à 1 pour garder la mise en page originale
  static const int tabletColumns = 2; // Restauré à 2
  static const int desktopColumns = 3; // Restauré à 3
  static const int largeDesktopColumns = 4; // Restauré à 4

  /// Espacement entre les éléments
  static const double defaultGap = 16;

  /// Marges horizontales par type d'écran
  static const Map<SFScreenSize, double> horizontalMargins = {
    SFScreenSize.mobile: 16,
    SFScreenSize.tablet: 24,
    SFScreenSize.desktop: 32,
    SFScreenSize.largeDesktop: 32,
  };

  /// Déterminer le type d'écran selon la largeur
  static SFScreenSize getScreenSize(double width) {
    if (width >= largeDesktopBreakpoint) return SFScreenSize.largeDesktop;
    if (width >= desktopBreakpoint) return SFScreenSize.desktop;
    if (width >= tabletBreakpoint) return SFScreenSize.tablet;
    return SFScreenSize.mobile;
  }

  /// Détermine l'orientation de l'écran
  static SFScreenOrientation getOrientation(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width > size.height
        ? SFScreenOrientation.landscape
        : SFScreenOrientation.portrait;
  }

  /// Obtient le nombre de colonnes pour une taille d'écran
  static int getColumnsForScreenSize(SFScreenSize size) {
    switch (size) {
      case SFScreenSize.mobile:
        return mobileColumns;
      case SFScreenSize.tablet:
        return tabletColumns;
      case SFScreenSize.desktop:
        return desktopColumns;
      case SFScreenSize.largeDesktop:
        return largeDesktopColumns;
    }
  }

  /// Récupère la marge horizontale pour un type d'écran
  static double getHorizontalMargin(SFScreenSize size) {
    return horizontalMargins[size] ?? defaultGap;
  }
}

/// Orientation de l'écran
enum SFScreenOrientation { portrait, landscape }
