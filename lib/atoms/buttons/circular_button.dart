import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFCircularButton extends StatelessWidget {
  final IconData icon;
  final ComponentSize size;
  final VoidCallback onPressed;
  final Color? iconColor;
  final Color? backgroundColor;
  final bool disabled;

  const SFCircularButton({
    required this.icon,
    required this.onPressed,
    this.size = ComponentSize.md,
    this.iconColor,
    this.backgroundColor,
    this.disabled = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Logique de couleur d'icône:
    // 1. Si iconColor est fourni, l'utiliser
    // 2. Sinon, si backgroundColor est transparent, utiliser la couleur d'icône du thème
    // 3. Sinon (fond coloré), utiliser blanc
    final Color effectiveIconColor =
        iconColor ??
        (backgroundColor == Colors.transparent
            ? Theme.of(context).iconTheme.color!
            : Colors.white);

    return SizedBox(
      width: _getButtonDimension(),
      height: _getButtonDimension(),
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: _getButtonStyle(context),
        child: Icon(
          icon,
          color: disabled ? AppColors.grey.s400 : effectiveIconColor,
          size: AppSizes.getIconSize(size),
        ),
      ),
    );
  }

  ButtonStyle? _getButtonStyle(BuildContext context) {
    final theme = Theme.of(context).elevatedButtonTheme.style;

    final baseStyle = theme?.copyWith(
      padding: WidgetStateProperty.all(EdgeInsets.zero),
      shape: WidgetStateProperty.all(const CircleBorder()),
      minimumSize: WidgetStateProperty.all(Size.square(_getButtonDimension())),
      fixedSize: WidgetStateProperty.all(Size.square(_getButtonDimension())),
      maximumSize: WidgetStateProperty.all(Size.square(_getButtonDimension())),
    );

    // Appliquer le style pour l'état disabled
    if (disabled) {
      return baseStyle?.copyWith(
        backgroundColor: WidgetStateProperty.all(AppColors.grey.s200),
        side: WidgetStateProperty.all(BorderSide(color: AppColors.grey.s200)),
      );
    }

    // Appliquer la couleur personnalisée si fournie
    if (backgroundColor != null) {
      return baseStyle?.copyWith(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          return backgroundColor;
        }),
      );
    }

    return baseStyle;
  }

  // Méthode pour obtenir la dimension du bouton en fonction de sa taille
  double _getButtonDimension() {
    switch (size) {
      case ComponentSize.xs:
        return 32.0;
      case ComponentSize.sm:
        return 40.0;
      case ComponentSize.md:
        return 48.0;
      case ComponentSize.lg:
        return 56.0;
      case ComponentSize.xl:
        return 64.0;
    }
  }
}
