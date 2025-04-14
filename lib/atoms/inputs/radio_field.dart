import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

/// Un champ de type radio qui permet de sélectionner une option parmi plusieurs.
///
/// Exemple d'utilisation :
/// ```dart
/// SFRadioField<String>(
///   options: ['Option A', 'Option B', 'Option C'],
///   groupValue: selectedOption,
///   onChanged: (value) => setState(() => selectedOption = value),
///   labelBuilder: (option) => option,
/// )
/// ```
///
/// [options] Liste des options disponibles.
/// [groupValue] Option actuellement sélectionnée.
/// [onChanged] Callback appelé lorsqu'une option est sélectionnée.
/// [labelBuilder] Fonction pour construire le label de chaque option.
/// [size] Taille des boutons.
/// [radius] Radius des boutons et du conteneur.
class SFRadioField<T> extends StatelessWidget {
  static const Duration _animationDuration = Duration(milliseconds: 200);

  final List<T> options;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final String Function(T) labelBuilder;
  final ComponentSize size;
  final double radius;
  final String? semanticsLabel;
  final String? semanticsHint;

  const SFRadioField({
    required this.options,
    required this.groupValue,
    required this.onChanged,
    required this.labelBuilder,
    this.size = ComponentSize.md,
    this.radius = 50,
    this.semanticsLabel,
    this.semanticsHint,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      hint: semanticsHint,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey.s200),
          borderRadius: BorderRadius.circular(radius),
        ),
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.xs,
          children:
              options.map((option) {
                final bool isSelected = option == groupValue;

                return AnimatedSwitcher(
                  duration: _animationDuration,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child:
                      isSelected
                          ? SFMainButton(
                            key: ValueKey(option),
                            label: labelBuilder(option),
                            size: size,
                            onPressed: null,
                            radius: radius,
                          )
                          : SFSecondaryButton(
                            key: ValueKey(option),
                            label: labelBuilder(option),
                            size: size,
                            onPressed: () => onChanged(option),
                            hideBorder: true,
                            radius: radius,
                          ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
