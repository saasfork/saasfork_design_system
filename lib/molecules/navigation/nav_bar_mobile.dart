import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:signals/signals_flutter.dart';

class SFNavBarMobile extends StatefulWidget {
  final List<SFNavLink> links;
  final Color? backgroundColor;
  final double height;

  const SFNavBarMobile({
    super.key,
    required this.links,
    this.backgroundColor,
    required this.height,
  });

  @override
  State<SFNavBarMobile> createState() => _SFNavBarMobileState();
}

class _SFNavBarMobileState extends State<SFNavBarMobile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  final _isMenuOpen = signal(false);
  OverlayEntry? _overlayEntry;
  OverlayEntry? _menuEntry;

  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _fadeAnimation = _animationController;

    effect(() {
      if (_isMenuOpen.value) {
        _animationController.forward();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _showMenuWithOverlay();
          }
        });
      } else {
        _animationController.reverse();

        if (_overlayEntry != null || _menuEntry != null) {
          void statusListener(AnimationStatus status) {
            if (status == AnimationStatus.dismissed) {
              _removeOverlays();
              _animationController.removeStatusListener(statusListener);
            }
          }

          _animationController.addStatusListener(statusListener);
        }
      }
    });
  }

  @override
  void dispose() {
    _removeOverlays();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    _isMenuOpen.value = !_isMenuOpen.value;
  }

  void _executeAfterMenuClosed(VoidCallback action) {
    _toggleMenu();

    void onAnimationStatusChanged(AnimationStatus status) {
      if (status == AnimationStatus.dismissed) {
        action();

        _animationController.removeStatusListener(onAnimationStatusChanged);
      }
    }

    _animationController.addStatusListener(onAnimationStatusChanged);
  }

  void _showMenuWithOverlay() {
    _removeOverlays();

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: widget.height,
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(opacity: _fadeAnimation, child: child);
              },
              child: GestureDetector(
                onTap: _toggleMenu,
                behavior: HitTestBehavior.opaque,
                child: Container(color: Colors.black.withAlpha(20)),
              ),
            ),
          ),
    );

    _menuEntry = OverlayEntry(
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final theme = Theme.of(context);

        return Positioned(
          top: widget.height,
          left: 0,
          child: ClipRect(
            child: Material(
              color: Colors.transparent,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: child,
                    ),
                  );
                },
                child: Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: widget.backgroundColor ?? theme.colorScheme.surface,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final link in widget.links)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          child: SFNavLinkItem(
                            link: link.copyWith(
                              onPress:
                                  () => _executeAfterMenuClosed(link.onPress),
                            ),
                            fullWidth: true,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    if (mounted) {
      Overlay.of(context).insert(_overlayEntry!);
      Overlay.of(context).insert(_menuEntry!);
    }
  }

  void _removeOverlays() {
    _overlayEntry?.remove();
    _overlayEntry = null;

    _menuEntry?.remove();
    _menuEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      return AnimatedSwitchButton(
        initialValue: _isMenuOpen.value,
        onToggle: (_) => _toggleMenu(),
        firstStateIcon: const Icon(Icons.menu_rounded),
        secondStateIcon: const Icon(Icons.close_rounded),
        firstStateColor: Colors.transparent,
        secondStateColor: Colors.transparent,
      );
    });
  }
}

extension SFNavLinkExtension on SFNavLink {
  SFNavLink copyWith({
    String? label,
    bool? isActive,
    VoidCallback? onPress,
    IconData? icon,
  }) {
    return SFNavLink(
      label: label ?? this.label,
      isActive: isActive ?? this.isActive,
      onPress: onPress ?? this.onPress,
      icon: icon ?? this.icon,
    );
  }
}
