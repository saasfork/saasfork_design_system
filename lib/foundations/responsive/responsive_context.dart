import 'package:flutter/material.dart';
import 'breakpoints.dart';

/// Extensions pour faciliter l'accès aux informations responsives
extension ResponsiveContext on BuildContext {
  /// Largeur de l'écran actuel
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Hauteur de l'écran actuel
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Type d'écran actuel
  SFScreenSize get screenSize => SFBreakpoints.getScreenSize(this);

  /// Orientation de l'écran
  SFScreenOrientation get orientation => SFBreakpoints.getOrientation(this);

  /// Nombre de colonnes pour l'écran actuel
  int get columns => SFBreakpoints.getColumnsForScreenSize(screenSize);

  /// Marge horizontale adaptée à la taille d'écran
  double get horizontalMargin => SFBreakpoints.getHorizontalMargin(screenSize);

  /// Espace entre les éléments adaptée à la taille d'écran
  double get gap => SFBreakpoints.defaultGap;

  /// Vérifications rapides pour le type d'écran
  bool get isMobile => screenSize == SFScreenSize.mobile;
  bool get isTablet => screenSize == SFScreenSize.tablet;
  bool get isDesktop => screenSize == SFScreenSize.desktop;
  bool get isLargeDesktop => screenSize == SFScreenSize.largeDesktop;

  /// Vérifications rapides pour l'orientation
  bool get isPortrait => orientation == SFScreenOrientation.portrait;
  bool get isLandscape => orientation == SFScreenOrientation.landscape;

  /// Vérifications plus générales
  bool get isMobileOrTablet => isMobile || isTablet;
  bool get isDesktopOrLarger => isDesktop || isLargeDesktop;

  /// Sélectionner une valeur en fonction du type d'écran
  T responsive<T>({required T mobile, T? tablet, T? desktop, T? largeDesktop}) {
    return switch (screenSize) {
      SFScreenSize.largeDesktop => largeDesktop ?? desktop ?? tablet ?? mobile,
      SFScreenSize.desktop => desktop ?? tablet ?? mobile,
      SFScreenSize.tablet => tablet ?? mobile,
      SFScreenSize.mobile => mobile,
    };
  }

  /// Appliquer une marge horizontale adaptative
  EdgeInsets get responsiveHorizontalPadding =>
      EdgeInsets.symmetric(horizontal: horizontalMargin);

  /// Padding adaptatif complet
  EdgeInsets get responsivePadding =>
      EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: gap);
}
