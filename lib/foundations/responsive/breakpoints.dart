import 'package:flutter/material.dart';

/// Types d'écrans supportés
enum ScreenSize {
  mobile, // < 600px
  tablet, // 600px - 900px
  desktop, // 900px - 1200px
  largeDesktop, // > 1200px
}

/// Configuration système pour la responsivité
class Breakpoints {
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
  static const Map<ScreenSize, double> horizontalMargins = {
    ScreenSize.mobile: 16,
    ScreenSize.tablet: 24,
    ScreenSize.desktop: 32,
    ScreenSize.largeDesktop: 32,
  };

  /// Déterminer le type d'écran selon la largeur
  static ScreenSize getScreenSize(double width) {
    if (width >= largeDesktopBreakpoint) return ScreenSize.largeDesktop;
    if (width >= desktopBreakpoint) return ScreenSize.desktop;
    if (width >= tabletBreakpoint) return ScreenSize.tablet;
    return ScreenSize.mobile;
  }

  /// Détermine l'orientation de l'écran
  static ScreenOrientation getOrientation(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width > size.height
        ? ScreenOrientation.landscape
        : ScreenOrientation.portrait;
  }

  /// Obtient le nombre de colonnes pour une taille d'écran
  static int getColumnsForScreenSize(ScreenSize size) {
    switch (size) {
      case ScreenSize.mobile:
        return mobileColumns;
      case ScreenSize.tablet:
        return tabletColumns;
      case ScreenSize.desktop:
        return desktopColumns;
      case ScreenSize.largeDesktop:
        return largeDesktopColumns;
    }
  }

  /// Récupère la marge horizontale pour un type d'écran
  static double getHorizontalMargin(ScreenSize size) {
    return horizontalMargins[size] ?? defaultGap;
  }
}

/// Orientation de l'écran
enum ScreenOrientation { portrait, landscape }
