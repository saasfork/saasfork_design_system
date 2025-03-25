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
  static const double desktopBreakpoint = 900;
  static const double largeDesktopBreakpoint = 1200;

  /// Nombre de colonnes par défaut pour chaque type d'écran
  static const int mobileColumns = 1;
  static const int tabletColumns = 2;
  static const int desktopColumns = 3;
  static const int largeDesktopColumns = 4;

  /// Espacement entre les éléments
  static const double defaultGap = 16;
  static const int defaultColumns = 12;

  /// Marges horizontales par type d'écran
  static const Map<SFScreenSize, double> horizontalMargins = {
    SFScreenSize.mobile: 16,
    SFScreenSize.tablet: 24,
    SFScreenSize.desktop: 32,
    SFScreenSize.largeDesktop: 32,
  };

  /// Détermine la taille de l'écran en fonction de la largeur
  static SFScreenSize getScreenSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
    return switch (size) {
      SFScreenSize.mobile => mobileColumns,
      SFScreenSize.tablet => tabletColumns,
      SFScreenSize.desktop => desktopColumns,
      SFScreenSize.largeDesktop => largeDesktopColumns,
    };
  }

  /// Récupère la marge horizontale pour un type d'écran
  static double getHorizontalMargin(SFScreenSize size) {
    return horizontalMargins[size] ?? defaultGap;
  }
}

/// Orientation de l'écran
enum SFScreenOrientation { portrait, landscape }
