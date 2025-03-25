import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/responsive/column_system.dart';
import 'package:saasfork_design_system/foundations/responsive/responsive.dart';

/// Un widget qui agit comme un conteneur de disposition responsive pour les [SFResponsiveColumn].
///
/// Organise ses enfants horizontalement et gère la disposition responsive en fonction
/// des points de rupture (breakpoints) définis. Cette classe fournit un contexte pour
/// que les colonnes enfants puissent déterminer leur largeur relative.
///
/// Paramètres:
/// - [children] : Liste des colonnes responsives à afficher dans la rangée.
/// - [totalColumns] : Nombre total de colonnes dans la grille (par défaut: 12).
/// - [spacing] : Espacement horizontal entre les colonnes.
/// - [verticalSpacing] : Espacement vertical lorsque les colonnes se wrappent sur plusieurs lignes.
/// - [mainAxisAlignment] : Alignement des enfants le long de l'axe principal.
/// - [crossAxisAlignment] : Alignement des enfants le long de l'axe transversal.
/// - [wrap] : Si true, les colonnes s'enrouleront sur plusieurs lignes si nécessaire.
///
/// Exemple d'utilisation:
/// ```dart
/// SFResponsiveRow(
///   spacing: 16.0,
///   verticalSpacing: 24.0,
///   children: [
///     SFResponsiveColumn(
///       xs: 12,
///       sm: 6,
///       md: 4,
///       child: Container(
///         height: 100,
///         color: Colors.blue,
///         child: Center(child: Text('Colonne 1')),
///       ),
///     ),
///     SFResponsiveColumn(
///       xs: 12,
///       sm: 6,
///       md: 4,
///       child: Container(
///         height: 100,
///         color: Colors.green,
///         child: Center(child: Text('Colonne 2')),
///       ),
///     ),
///     SFResponsiveColumn(
///       xs: 12,
///       sm: 12,
///       md: 4,
///       child: Container(
///         height: 100,
///         color: Colors.orange,
///         child: Center(child: Text('Colonne 3')),
///       ),
///     ),
///   ],
/// )
/// ```
///
/// Sur un écran mobile, chaque colonne occupera toute la largeur.
/// Sur une tablette, les deux premières colonnes partageront une ligne, et la troisième sera sur une nouvelle ligne.
/// Sur un desktop, toutes les colonnes seront disposées sur une seule ligne, chacune occupant un tiers de la largeur.
class SFResponsiveRow extends StatelessWidget {
  final List<Widget> children;
  final double? spacing;
  final bool wrap;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final int totalColumns;

  const SFResponsiveRow({
    required this.children,
    this.spacing,
    this.wrap = true,
    this.margin,
    this.padding,
    this.totalColumns = 12,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveSpacing = spacing ?? SFBreakpoints.defaultGap;

    return ResponsiveRowScope(
      totalColumns: totalColumns,
      wrap: wrap,
      child: Container(
        margin: margin,
        padding: padding,
        child:
            wrap
                ? _buildWrapLayout(effectiveSpacing, context)
                : _buildRowLayout(effectiveSpacing),
      ),
    );
  }

  Widget _buildWrapLayout(double spacing, BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int totalSpan = 0;
        final screenSize = SFBreakpoints.getScreenSize(context);

        for (var child in children) {
          if (child is SFResponsiveColumn) {
            int? span;
            switch (screenSize) {
              case SFScreenSize.mobile:
                span = child.xs;
                break;
              case SFScreenSize.tablet:
                span = child.sm ?? child.xs;
                break;
              case SFScreenSize.desktop:
                span = child.md ?? child.sm ?? child.xs;
                break;
              case SFScreenSize.largeDesktop:
                span = child.lg ?? child.md ?? child.sm ?? child.xs;
                break;
            }

            totalSpan += span ?? totalColumns;
          } else {
            totalSpan += 1;
          }
        }

        if (totalSpan <= totalColumns) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spacing,
            children: [
              for (int i = 0; i < children.length; i++) ...[
                if (children[i] is SFResponsiveColumn)
                  children[i]
                else
                  Expanded(child: children[i]),
              ],
            ],
          );
        }

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children:
              children.map((child) {
                if (child is SFResponsiveColumn) {
                  return child;
                } else {
                  return SFResponsiveColumn(xs: 12, child: child);
                }
              }).toList(),
        );
      },
    );
  }

  Widget _buildRowLayout(double spacing) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spacing,
      children: [
        for (int i = 0; i < children.length; i++) ...[
          if (children[i] is SFResponsiveColumn)
            children[i]
          else
            Expanded(child: children[i]),
        ],
      ],
    );
  }
}

/// Classe qui fournit des informations de contexte pour les colonnes enfants
class ResponsiveRowScope extends InheritedWidget {
  final int totalColumns;
  final bool wrap;
  final double spacing;

  const ResponsiveRowScope({
    super.key,
    this.totalColumns = SFColumnSystem.defaultTotalColumns,
    this.wrap = true,
    this.spacing = SFBreakpoints.defaultGap,
    required super.child,
  });

  // Accès pratique depuis n'importe quel widget
  static ResponsiveRowScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ResponsiveRowScope>();
  }

  // Valeurs par défaut quand aucun scope n'est trouvé
  static int getColumns(BuildContext context) {
    return of(context)?.totalColumns ?? SFColumnSystem.defaultTotalColumns;
  }

  static double getSpacing(BuildContext context) {
    return of(context)?.spacing ?? SFBreakpoints.defaultGap;
  }

  static bool isWrap(BuildContext context) {
    return of(context)?.wrap ?? true;
  }

  @override
  bool updateShouldNotify(ResponsiveRowScope oldWidget) {
    return totalColumns != oldWidget.totalColumns ||
        wrap != oldWidget.wrap ||
        spacing != oldWidget.spacing;
  }
}
