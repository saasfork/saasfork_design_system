import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:signals/signals_flutter.dart';

/// Un bouton de basculement entre mode clair et sombre avec animation.
///
/// Ce composant affiche une icône de soleil ou de lune selon le mode actuel,
/// et permet à l'utilisateur de basculer entre les deux états avec une animation fluide.
///
/// [onToggle] est appelé avec la nouvelle valeur (true = sombre, false = clair) après chaque changement.
/// [initialValue] définit l'état initial (true = sombre, false = clair).
/// [lightModeColor] et [darkModeColor] permettent de personnaliser les couleurs des deux états.
/// [size] contrôle la taille du bouton selon les tailles standard du design system.
class SFToggleSimpleButton extends StatefulWidget {
  final Function(bool) onToggle;
  final bool initialValue;
  final Color? lightModeColor;
  final Color? darkModeColor;
  final ComponentSize size;

  const SFToggleSimpleButton({
    super.key,
    required this.onToggle,
    this.initialValue = false,
    this.lightModeColor,
    this.darkModeColor,
    this.size = ComponentSize.md,
  });

  @override
  State<SFToggleSimpleButton> createState() => _SFToggleSimpleButtonState();
}

class _SFToggleSimpleButtonState extends State<SFToggleSimpleButton>
    with SingleTickerProviderStateMixin {
  late final Signal<bool> _isDarkMode;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _isDarkMode = signal(widget.initialValue);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Initialiser l'état de l'animation selon la valeur initiale
    if (_isDarkMode.value) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMode() {
    _isDarkMode.value = !_isDarkMode.peek();

    if (_isDarkMode.value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    widget.onToggle(_isDarkMode.value);
  }

  @override
  Widget build(BuildContext context) {
    final lightColor = widget.lightModeColor ?? AppColors.orange;
    final darkColor = widget.darkModeColor ?? AppColors.indigo;

    return Watch((context) {
      final isDark = _isDarkMode.value;

      final IconData iconData =
          isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded;

      final Color buttonColor =
          isDark
              ? (widget.darkModeColor ?? darkColor)
              : (widget.lightModeColor ?? lightColor);

      return SFCircularButton(
        icon: iconData,
        size: widget.size,
        iconColor: Colors.white,
        onPressed: _toggleMode,
        backgroundColor: buttonColor,
      );
    });
  }
}
