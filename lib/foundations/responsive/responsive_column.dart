import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/responsive/column_system.dart';
import 'breakpoints.dart';
import 'responsive_row.dart';

/// Un widget qui s'adapte automatiquement à différentes tailles d'écran en ajustant sa largeur.
///
/// Permet de définir des largeurs différentes selon le breakpoint (mobile, tablette, desktop, grand desktop).
/// Cette colonne peut être utilisée comme enfant direct d'un [SFResponsiveRow] ou comme widget autonome.
///
/// Paramètres:
/// - [child] : Widget à afficher dans la colonne.
/// - [xs] : Nombre de colonnes à occuper sur les écrans mobiles (0-12).
/// - [sm] : Nombre de colonnes à occuper sur les écrans tablettes. Si null, utilise xs.
/// - [md] : Nombre de colonnes à occuper sur les écrans desktop. Si null, utilise sm ou xs.
/// - [lg] : Nombre de colonnes à occuper sur les grands écrans. Si null, utilise md, sm ou xs.
/// - [padding] : Espacement interne de la colonne.
/// - [decoration] : Décoration visuelle de la colonne.
/// - [alignment] : Alignement du contenu dans la colonne.
///
/// Exemple d'utilisation:
/// ```dart
/// SFResponsiveRow(
///   children: [
///     SFResponsiveColumn(
///       xs: 12,     // Pleine largeur sur mobile
///       sm: 6,      // Demi-largeur sur tablette
///       md: 4,      // Tiers de largeur sur desktop
///       lg: 3,      // Quart de largeur sur grand écran
///       padding: EdgeInsets.all(16.0),
///       decoration: BoxDecoration(
///         color: Colors.grey[200],
///         borderRadius: BorderRadius.circular(8.0),
///       ),
///       child: Text('Contenu responsive'),
///     ),
///     SFResponsiveColumn(
///       xs: 12,
///       sm: 6,
///       child: Text('Autre colonne'),
///     ),
///   ],
/// )
/// ```
class SFResponsiveColumn extends StatelessWidget {
  final Widget child;
  final int? xs;
  final int? sm;
  final int? md;
  final int? lg;
  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;
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
    final screenSize = SFBreakpoints.getScreenSize(context);

    // Utiliser la méthode centralisée pour obtenir le span effectif
    final effectiveSpan = SFColumnSystem.getEffectiveSpan(
      screenSize: screenSize,
      xs: xs,
      sm: sm,
      md: md,
      lg: lg,
    );

    // Obtenir le nombre total de colonnes du contexte
    final totalColumns = ResponsiveRowScope.getColumns(context);

    // Contenu avec padding et décoration
    final content = Container(
      padding: padding,
      decoration: decoration,
      child:
          alignment != null
              ? Align(alignment: alignment!, child: child)
              : child,
    );

    // Détecter si le parent est un Row ou un Wrap
    final withinResponsiveRow = ResponsiveRowScope.of(context) != null;
    final parentIsRow = context.findAncestorWidgetOfExactType<Row>() != null;

    // Dans un Row, utiliser Flexible; sinon FractionallySizedBox
    if (parentIsRow && withinResponsiveRow) {
      return Flexible(flex: effectiveSpan, child: content);
    } else {
      return FractionallySizedBox(
        widthFactor: SFColumnSystem.calculateWidthFactor(
          effectiveSpan,
          totalColumns,
        ),
        child: content,
      );
    }
  }
}
