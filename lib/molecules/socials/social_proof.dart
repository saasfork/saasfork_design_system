import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:saasfork_design_system/utils/implementations/images/image_source.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Widget affichant une preuve sociale avec des avatars et un texte.
///
/// Ce composant permet d'afficher une preuve sociale visuelle qui combine des avatars
/// d'utilisateurs avec un texte descriptif. Idéal pour montrer l'adoption d'un produit
/// ou service par d'autres utilisateurs.
///
/// ## Cas d'utilisation
/// - Afficher le nombre d'utilisateurs qui utilisent déjà un produit
/// - Montrer des témoignages avec les avatars des clients
/// - Indiquer combien de personnes ont participé à une action spécifique
/// - Valoriser une fonctionnalité en montrant son adoption par d'autres utilisateurs
///
/// ## Exemple
/// ```dart
/// SFSocialProof(
///   imageUrls: ['https://example.com/avatar1.jpg', 'https://example.com/avatar2.jpg'],
///   text: '1243 personnes ont déjà souscrit à cette offre',
/// )
/// ```
///
/// [imageUrls] Liste des URLs des images d'avatars.
/// [text] Texte descriptif à afficher.
/// [imageSize] Taille des images d'avatar (par défaut 40.0).
/// [spacing] Espacement entre les éléments.
/// [maxWidth] Largeur maximale du composant (par défaut 80% de l'écran).
/// [semanticsLabel] Texte personnalisé pour l'accessibilité (lecteurs d'écran).
/// [isLoading] Indique si le composant est en état de chargement.
/// [skeletonAvatarCount] Nombre d'avatars à afficher dans le squelette (par défaut 3).
class SFSocialProof extends StatelessWidget {
  final List<String> imageUrls;
  final String text;
  final double imageSize;
  final ComponentSize spacing;
  final double? maxWidth;
  final String? semanticsLabel;
  final bool isLoading;
  final int skeletonAvatarCount;

  const SFSocialProof({
    super.key,
    required this.imageUrls,
    required this.text,
    this.imageSize = 40.0,
    this.spacing = ComponentSize.md,
    this.maxWidth,
    this.semanticsLabel,
    this.isLoading = false,
    this.skeletonAvatarCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    // Si le widget est en chargement, afficher le squelette
    if (isLoading) {
      return _buildSkeleton(context);
    }

    final TextStyle scaledStyle = AppTypography.getScaledStyle(
      AppTypography.bodyLarge,
      spacing,
    );

    final double scaleFactor =
        scaledStyle.fontSize! / AppTypography.bodyLarge.fontSize!;
    final double adjustedImageSize = imageSize * scaleFactor;

    const double borderWidth = 2.0;
    final double totalImageSize = adjustedImageSize + borderWidth * 2;
    final double overlapFactor = 0.6;

    final stackWidth =
        imageUrls.isEmpty
            ? 0.0
            : totalImageSize +
                (imageUrls.length - 1) * (totalImageSize * overlapFactor);

    final String accessibilityLabel =
        semanticsLabel ?? 'Social proof with ${imageUrls.length} users';

    return IntrinsicWidth(
      child: Semantics(
        label: accessibilityLabel,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? MediaQuery.of(context).size.width * 0.8,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: AppSpacing.xs,
            children: [
              SizedBox(
                width: stackWidth,
                height: adjustedImageSize + borderWidth * 2,
                child:
                    imageUrls.isEmpty
                        ? const SizedBox.shrink()
                        : _buildAvatarStack(
                          context,
                          adjustedImageSize,
                          borderWidth,
                          totalImageSize,
                          overlapFactor,
                        ),
              ),
              Flexible(
                child: Text(
                  text,
                  style: scaledStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarStack(
    BuildContext context,
    double adjustedImageSize,
    double borderWidth,
    double totalImageSize,
    double overlapFactor,
  ) {
    return Stack(
      children:
          imageUrls.asMap().entries.map((entry) {
            int index = entry.key;
            String url = entry.value;
            return Positioned(
              left: index * (totalImageSize * overlapFactor),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.surface,
                    width: borderWidth,
                  ),
                ),
                child: SFImageCircle(
                  diameter: adjustedImageSize,
                  imageSource: UrlImageSource(url),
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    // Appliquer le même facteur d'échelle au squelette qu'au widget normal
    final TextStyle scaledStyle = AppTypography.getScaledStyle(
      AppTypography.bodyLarge,
      spacing,
    );

    final double scaleFactor =
        scaledStyle.fontSize! / AppTypography.bodyLarge.fontSize!;
    final double adjustedImageSize = imageSize * scaleFactor;

    const double borderWidth = 2.0;
    final double totalImageSize = adjustedImageSize + borderWidth * 2;
    final double overlapFactor = 0.6;

    final double stackWidth =
        totalImageSize +
        (skeletonAvatarCount - 1) * (totalImageSize * overlapFactor);

    return Skeletonizer.zone(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? MediaQuery.of(context).size.width * 0.8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: AppSpacing.xs,
          children: [
            // Stack d'avatars
            SizedBox(
              width: stackWidth,
              height: totalImageSize,
              child: Stack(
                children: List.generate(skeletonAvatarCount, (index) {
                  return Positioned(
                    left: index * (totalImageSize * overlapFactor),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.surface,
                          width: borderWidth,
                        ),
                      ),
                      // Utiliser la taille ajustée pour le squelette
                      child: Bone.circle(size: adjustedImageSize),
                    ),
                  );
                }),
              ),
            ),
            // Texte du skeleton - utiliser le style mis à l'échelle
            Flexible(
              child: Text(
                text,
                style: scaledStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
