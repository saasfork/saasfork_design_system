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

  /// Alignement des éléments dans la grille
  final WrapAlignment alignment;

  /// Espacement vertical entre les lignes
  final double? runSpacing;

  SFResponsiveGrid({
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
    this.alignment = WrapAlignment.start,
    this.runSpacing,
    super.key,
  }) {
    // Validation des colonnes
    assert(
      mobileColumns == null || mobileColumns! > 0,
      'Le nombre de colonnes doit être positif',
    );
    assert(
      tabletColumns == null || tabletColumns! > 0,
      'Le nombre de colonnes doit être positif',
    );
    assert(
      desktopColumns == null || desktopColumns! > 0,
      'Le nombre de colonnes doit être positif',
    );
    assert(
      largeDesktopColumns == null || largeDesktopColumns! > 0,
      'Le nombre de colonnes doit être positif',
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenSize = SFBreakpoints.getScreenSize(context);
        final effectiveSpacing = spacing ?? SFBreakpoints.defaultGap;
        final effectiveRunSpacing = runSpacing ?? effectiveSpacing;

        // Calcul du nombre de colonnes effectif
        final columns = _getEffectiveColumns(screenSize);

        // Calculs précis de la largeur
        final double availableWidth = constraints.maxWidth;
        final double totalSpacing = effectiveSpacing * (columns - 1);
        final double itemWidth = (availableWidth - totalSpacing) / columns;

        return Container(
          margin: margin,
          padding: padding,
          child: Wrap(
            spacing: effectiveSpacing,
            runSpacing: effectiveRunSpacing,
            alignment: alignment,
            children: List.generate(
              children.length,
              (index) => SizedBox(width: itemWidth, child: children[index]),
            ),
          ),
        );
      },
    );
  }

  int _getEffectiveColumns(SFScreenSize size) {
    return switch (size) {
      SFScreenSize.mobile => mobileColumns ?? SFBreakpoints.mobileColumns,
      SFScreenSize.tablet => tabletColumns ?? SFBreakpoints.tabletColumns,
      SFScreenSize.desktop => desktopColumns ?? SFBreakpoints.desktopColumns,
      SFScreenSize.largeDesktop =>
        largeDesktopColumns ?? SFBreakpoints.largeDesktopColumns,
    };
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

/// Fonction utilitaire pour obtenir le padding horizontal responsive
EdgeInsetsGeometry getResponsiveHorizontalPadding(BuildContext context) {
  return EdgeInsets.symmetric(
    horizontal: SFBreakpoints.getHorizontalMargin(
      SFBreakpoints.getScreenSize(context),
    ),
  );
}
