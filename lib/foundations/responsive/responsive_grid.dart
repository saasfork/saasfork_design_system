import 'package:flutter/material.dart';
import 'breakpoints.dart';

/// Grille responsive qui adapte automatiquement le nombre de colonnes
class SFResponsiveGrid extends StatelessWidget {
  /// Enfants de la grille
  final List<Widget> children;

  /// Nombre de colonnes par type d'écran (null = valeur par défaut)
  final int? mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;
  final int? largeDesktopColumns;

  /// Espace entre les éléments
  final double? spacing;

  /// Marge autour de la grille
  final EdgeInsetsGeometry? margin;

  /// Padding à l'intérieur de la grille
  final EdgeInsetsGeometry? padding;

  /// Largeur maximale de la grille (optionnel)
  final double? maxWidth;

  /// Mode "maximisé" pour optimiser l'utilisation de l'espace sur grands écrans
  final bool maximize;

  const SFResponsiveGrid({
    required this.children,
    this.mobileColumns,
    this.tabletColumns,
    this.desktopColumns,
    this.largeDesktopColumns,
    this.spacing,
    this.margin,
    this.padding,
    this.maxWidth,
    this.maximize = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenSize = SFBreakpoints.getScreenSize(context);
        final effectiveSpacing = spacing ?? SFBreakpoints.defaultGap;

        // Conserver les valeurs d'origine
        int columns;
        switch (screenSize) {
          case SFScreenSize.mobile:
            columns = mobileColumns ?? SFBreakpoints.mobileColumns;
            break;
          case SFScreenSize.tablet:
            columns = tabletColumns ?? SFBreakpoints.tabletColumns;
            break;
          case SFScreenSize.desktop:
            columns = desktopColumns ?? SFBreakpoints.desktopColumns;
            break;
          case SFScreenSize.largeDesktop:
            columns = largeDesktopColumns ?? SFBreakpoints.largeDesktopColumns;
            break;
        }

        // Calculs précis de la largeur
        final double availableWidth = constraints.maxWidth;
        final double totalSpacing = effectiveSpacing * (columns - 1);
        final double itemWidth = (availableWidth - totalSpacing) / columns;

        // Utilisation de Wrap pour préserver le comportement de passage à la ligne
        return Container(
          margin: margin,
          padding: padding,
          child: Wrap(
            spacing: effectiveSpacing,
            runSpacing: effectiveSpacing,
            alignment: WrapAlignment.start, // Alignement original
            children: List.generate(
              children.length,
              (index) => SizedBox(width: itemWidth, child: children[index]),
            ),
          ),
        );
      },
    );
  }
}

/// Conteneur responsive avec largeur maximale
class SFResponsiveContainer extends StatelessWidget {
  /// Contenu
  final Widget child;

  /// Largeur maximale
  final double? maxWidth;

  /// Padding interne
  final EdgeInsetsGeometry? padding;

  /// Marge externe
  final EdgeInsetsGeometry? margin;

  /// Décoration
  final BoxDecoration? decoration;

  /// Aligner le contenu au centre
  final bool center;

  const SFResponsiveContainer({
    required this.child,
    this.maxWidth,
    this.padding,
    this.margin,
    this.decoration,
    this.center = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding ?? getResponsiveHorizontalPadding(context);

    return Container(
      width: double.infinity,
      margin: margin,
      padding: effectivePadding,
      decoration: decoration,
      child:
          center && maxWidth != null
              ? Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth!),
                  child: child,
                ),
              )
              : child,
    );
  }
}

// Fonction utilitaire pour obtenir le padding horizontal responsive
EdgeInsetsGeometry getResponsiveHorizontalPadding(BuildContext context) {
  final screenSize = SFBreakpoints.getScreenSize(context);
  double horizontalPadding;

  switch (screenSize) {
    case SFScreenSize.mobile:
      horizontalPadding = 16.0;
      break;
    case SFScreenSize.tablet:
      horizontalPadding = 24.0;
      break;
    case SFScreenSize.desktop:
      horizontalPadding = 32.0;
      break;
    case SFScreenSize.largeDesktop:
      horizontalPadding = 48.0;
      break;
  }

  return EdgeInsets.symmetric(horizontal: horizontalPadding);
}
