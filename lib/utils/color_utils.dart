import 'package:flutter/material.dart';

class ColorUtils {
  /// Ajuste la luminosité d'une couleur (facteur entre -1 et 1)
  static Color adjustBrightness(Color color, double factor) {
    HSLColor hsl = HSLColor.fromColor(color);
    double newLightness = (hsl.lightness + factor).clamp(0.0, 1.0);
    return hsl.withLightness(newLightness).toColor();
  }

  /// Génère dynamiquement une palette complète `50 → 950`
  static Map<int, Color> generateShades(Color baseColor) {
    return {
      50: adjustBrightness(baseColor, 0.50),
      100: adjustBrightness(baseColor, 0.40),
      200: adjustBrightness(baseColor, 0.30),
      300: adjustBrightness(baseColor, 0.20),
      400: adjustBrightness(baseColor, 0.10),
      500: baseColor,
      600: adjustBrightness(baseColor, -0.10),
      700: adjustBrightness(baseColor, -0.20),
      800: adjustBrightness(baseColor, -0.30),
      900: adjustBrightness(baseColor, -0.40),
      950: adjustBrightness(baseColor, -0.50),
    };
  }
}
