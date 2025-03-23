import 'package:flutter/material.dart';
import 'breakpoints.dart';

/// Extensions pour faciliter l'accès aux informations responsives
extension ResponsiveContext on BuildContext {
  /// Largeur de l'écran actuel
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Hauteur de l'écran actuel
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Type d'écran actuel
  ScreenSize get screenSize => Breakpoints.getScreenSize(screenWidth);

  /// Orientation de l'écran
  ScreenOrientation get orientation => Breakpoints.getOrientation(this);

  /// Nombre de colonnes pour l'écran actuel
  int get columns => Breakpoints.getColumnsForScreenSize(screenSize);

  /// Marge horizontale adaptée à la taille d'écran
  double get horizontalMargin => Breakpoints.getHorizontalMargin(screenSize);

  /// Espace entre les éléments adaptée à la taille d'écran
  double get gap => Breakpoints.defaultGap;

  /// Vérifications rapides pour le type d'écran
  bool get isMobile => screenSize == ScreenSize.mobile;
  bool get isTablet => screenSize == ScreenSize.tablet;
  bool get isDesktop => screenSize == ScreenSize.desktop;
  bool get isLargeDesktop => screenSize == ScreenSize.largeDesktop;

  /// Vérifications rapides pour l'orientation
  bool get isPortrait => orientation == ScreenOrientation.portrait;
  bool get isLandscape => orientation == ScreenOrientation.landscape;

  /// Vérifications plus générales
  bool get isMobileOrTablet => isMobile || isTablet;
  bool get isDesktopOrLarger => isDesktop || isLargeDesktop;

  /// Sélectionner une valeur en fonction du type d'écran (version simplifiée)
  T responsive<T>({required T mobile, T? tablet, T? desktop, T? largeDesktop}) {
    // Version plus concise avec cascade
    return switch (screenSize) {
      ScreenSize.largeDesktop => largeDesktop ?? desktop ?? tablet ?? mobile,
      ScreenSize.desktop => desktop ?? tablet ?? mobile,
      ScreenSize.tablet => tablet ?? mobile,
      ScreenSize.mobile => mobile,
    };
  }

  /// Appliquer une marge horizontale adaptative
  EdgeInsets get responsiveHorizontalPadding =>
      EdgeInsets.symmetric(horizontal: horizontalMargin);

  /// Padding adaptatif complet
  EdgeInsets get responsivePadding =>
      EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: gap);
}
