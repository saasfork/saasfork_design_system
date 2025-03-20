import 'package:flutter/material.dart';
import 'package:saasfork_design_system/utils/color_utils.dart';

class AppColor extends Color {
  final Color s50;
  final Color s100;
  final Color s200;
  final Color s300;
  final Color s400;
  final Color s500; // Couleur principale
  final Color s600;
  final Color s700;
  final Color s800;
  final Color s900;
  final Color s950; // Ajout de la teinte la plus foncée

  /// Constructeur qui permet d'utiliser AppColor comme une Color directement
  AppColor({
    required this.s50,
    required this.s100,
    required this.s200,
    required this.s300,
    required this.s400,
    required this.s500,
    required this.s600,
    required this.s700,
    required this.s800,
    required this.s900,
    required this.s950,
  }) : super(s500.toARGB32());

  /// Génère une palette complète de `50` à `950` à partir d'une couleur de base
  factory AppColor.fromBase(Color baseColor) {
    final shades = ColorUtils.generateShades(baseColor);
    return AppColor(
      s50: shades[50]!,
      s100: shades[100]!,
      s200: shades[200]!,
      s300: shades[300]!,
      s400: shades[400]!,
      s500: shades[500]!,
      s600: shades[600]!,
      s700: shades[700]!,
      s800: shades[800]!,
      s900: shades[900]!,
      s950: shades[950]!, // Ajout de la nouvelle nuance 950
    );
  }
}
