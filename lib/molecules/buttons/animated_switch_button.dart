import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:signals/signals_flutter.dart';

class AnimatedSwitchButton extends StatefulWidget {
  final Function(bool) onToggle;
  final bool initialValue;
  final Color? firstStateColor;
  final Color? secondStateColor;
  final Icon? firstStateIcon;
  final Icon? secondStateIcon;
  final Color? firstStateIconColor;
  final Color? secondStateIconColor;
  final ComponentSize size;

  const AnimatedSwitchButton({
    super.key,
    required this.onToggle,
    this.initialValue = false,
    this.firstStateColor,
    this.secondStateColor,
    this.firstStateIcon,
    this.secondStateIcon,
    this.firstStateIconColor,
    this.secondStateIconColor,
    this.size = ComponentSize.md,
  });

  @override
  State<AnimatedSwitchButton> createState() => _AnimatedSwitchButtonState();
}

class _AnimatedSwitchButtonState extends State<AnimatedSwitchButton>
    with SingleTickerProviderStateMixin {
  late final Signal<bool> _isSecondState;
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _isSecondState = signal(widget.initialValue);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    if (_isSecondState.value) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateColorAnimations();
  }

  void _updateColorAnimations() {
    final theme = Theme.of(context);
    final firstColor = widget.firstStateColor ?? theme.colorScheme.primary;
    final secondColor = widget.secondStateColor ?? theme.colorScheme.secondary;

    _colorAnimation = ColorTween(
      begin: firstColor,
      end: secondColor,
    ).animate(_animationController);
  }

  @override
  void didUpdateWidget(AnimatedSwitchButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.firstStateColor != widget.firstStateColor ||
        oldWidget.secondStateColor != widget.secondStateColor) {
      _updateColorAnimations();
    }

    if (oldWidget.initialValue != widget.initialValue) {
      _isSecondState.value = widget.initialValue;

      if (widget.initialValue) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleState() {
    _isSecondState.value = !_isSecondState.peek();

    if (_isSecondState.value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    widget.onToggle(_isSecondState.value);
  }

  Widget _buildAnimatedIcon(
    IconData iconData,
    Color? color,
    double opacity,
    double scale,
    double rotation,
  ) {
    return Opacity(
      opacity: opacity,
      child: Transform.scale(
        scale: scale,
        child: Transform.rotate(
          angle: rotation,
          child: Icon(
            iconData,
            color: color,
            size: AppSizes.getIconSize(widget.size),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final firstColor = widget.firstStateColor;
    final secondColor = widget.secondStateColor;

    final effectiveFirstColor = firstColor ?? theme.colorScheme.primary;
    final effectiveSecondColor = secondColor ?? theme.colorScheme.secondary;

    final IconData firstIconData =
        widget.firstStateIcon?.icon ?? Icons.light_mode_rounded;
    final IconData secondIconData =
        widget.secondStateIcon?.icon ?? Icons.dark_mode_rounded;

    return Watch((context) {
      final isSecond = _isSecondState.value;

      Color? getIconColor(bool isSecondState) {
        final iconColor =
            isSecondState
                ? widget.secondStateIconColor
                : widget.firstStateIconColor;
        final backgroundColor = isSecondState ? secondColor : firstColor;
        final effectiveColor =
            isSecondState ? effectiveSecondColor : effectiveFirstColor;

        if (iconColor != null) return iconColor;

        if (backgroundColor == Colors.transparent || backgroundColor == null) {
          return theme.textTheme.bodyLarge?.color;
        }

        return ThemeUtils.getContrastColor(effectiveColor);
      }

      final firstIconColor = getIconColor(false);
      final secondIconColor = getIconColor(true);

      return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return GestureDetector(
            onTap: _toggleState,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    _colorAnimation.value ??
                    (isSecond ? effectiveSecondColor : effectiveFirstColor),
              ),
              padding: EdgeInsets.all(
                AppSizes.getCircularButtonPadding(widget.size),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildAnimatedIcon(
                    firstIconData,
                    firstIconColor,
                    1.0 - _animationController.value,
                    1.0 - 0.3 * _animationController.value,
                    -0.5 * 3.14 * _animationController.value,
                  ),

                  _buildAnimatedIcon(
                    secondIconData,
                    secondIconColor,
                    _animationController.value,
                    0.7 + 0.3 * _animationController.value,
                    3.14 * (1 - _animationController.value),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

class ThemeUtils {
  static Color? getContrastColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();

    if (luminance > 0.5) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }
}
