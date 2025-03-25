// Nouveau fichier: column_system.dart
import 'package:saasfork_design_system/foundations/foundations.dart';

class SFColumnSystem {
  // Constantes partagées
  static const int defaultTotalColumns = 12;

  // Méthode pour calculer la fraction de largeur
  static double calculateWidthFactor(int span, int totalColumns) {
    return span / totalColumns;
  }

  // Méthode pour déterminer le span effectif en fonction de la taille d'écran
  static int getEffectiveSpan({
    required SFScreenSize screenSize,
    int? xs,
    int? sm,
    int? md,
    int? lg,
    int defaultSpan = defaultTotalColumns,
  }) {
    switch (screenSize) {
      case SFScreenSize.mobile:
        return xs ?? defaultSpan;
      case SFScreenSize.tablet:
        return sm ?? xs ?? defaultSpan;
      case SFScreenSize.desktop:
        return md ?? sm ?? xs ?? defaultSpan;
      case SFScreenSize.largeDesktop:
        return lg ?? md ?? sm ?? xs ?? defaultSpan;
    }
  }
}
