import 'package:flutter/material.dart';
import 'breakpoints.dart';
import 'responsive_context.dart';

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
        final screenSize = context.screenSize;
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

/// Ligne responsive avec des colonnes de largeurs variables
class SFResponsiveRow extends StatelessWidget {
  /// Enfants de la ligne (avec leurs spans)
  final List<Widget> children;

  /// Espacement entre les colonnes
  final double? spacing;

  /// Mode Wrap pour passer à la ligne si nécessaire
  final bool wrap;

  /// Marge externe de la ligne
  final EdgeInsetsGeometry? margin;

  /// Padding interne de la ligne
  final EdgeInsetsGeometry? padding;

  const SFResponsiveRow({
    required this.children,
    this.spacing,
    this.wrap = true,
    this.margin,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveSpacing = spacing ?? context.gap;

    // Mode Row s'il n'y a pas besoin de wrap ou si explicitement défini
    if (!wrap) {
      return Container(
        margin: margin,
        padding: padding,
        child: Row(
          children: [
            for (int i = 0; i < children.length; i++) ...[
              Expanded(child: children[i]),
              if (i < children.length - 1) SizedBox(width: effectiveSpacing),
            ],
          ],
        ),
      );
    }

    // Mode Wrap pour le responsive complet
    return Container(
      margin: margin,
      padding: padding,
      child: Wrap(
        spacing: effectiveSpacing,
        runSpacing: effectiveSpacing,
        children: children,
      ),
    );
  }
}

/// Colonne responsive à largeur variable
class SFResponsiveColumn extends StatelessWidget {
  /// Contenu de la colonne
  final Widget child;

  /// Span sur mobile (1-12)
  final int? xs;

  /// Span sur tablette (1-12)
  final int? sm;

  /// Span sur desktop (1-12)
  final int? md;

  /// Span sur large desktop (1-12)
  final int? lg;

  /// Padding interne
  final EdgeInsetsGeometry? padding;

  /// Décoration
  final BoxDecoration? decoration;

  /// Alignement du contenu
  final Alignment? alignment;

  const SFResponsiveColumn({
    required this.child,
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.padding,
    this.decoration,
    this.alignment,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = context.screenSize;

    // Détermine le span pour le type d'écran actuel
    int? span;
    switch (screenSize) {
      case SFScreenSize.mobile:
        span = xs;
        break;
      case SFScreenSize.tablet:
        span = sm ?? xs;
        break;
      case SFScreenSize.desktop:
        span = md ?? sm ?? xs;
        break;
      case SFScreenSize.largeDesktop:
        span = lg ?? md ?? sm ?? xs;
        break;
    }

    // Si span est null, utilise la largeur complète
    final int totalColumns = context.columns;
    final int effectiveSpan = span ?? totalColumns;

    // Calcul de la largeur relative (fraction)
    final double widthFactor = effectiveSpan / totalColumns;

    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Container(
        padding: padding,
        decoration: decoration,
        child:
            alignment != null
                ? Align(alignment: alignment!, child: child)
                : child,
      ),
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
    final effectivePadding = padding ?? context.responsiveHorizontalPadding;

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
