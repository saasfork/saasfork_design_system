import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFNavBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<SFNavLink> links;
  final List<Widget> actions;
  final double height;
  final Color? backgroundColor;
  final double horizontalPadding;

  const SFNavBar({
    this.leading,
    this.links = const [],
    this.actions = const [],
    this.height = 52.0,
    this.backgroundColor,
    this.horizontalPadding = 16.0,
    super.key,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      color: backgroundColor ?? Theme.of(context).colorScheme.surface,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child:
          context.isDesktopOrLarger
              ? _buildDesktopLayout()
              : _buildMobileLayout(
                backgroundColor ?? Theme.of(context).colorScheme.surface,
              ),
    );
  }

  Widget _buildActionButtons({Alignment alignment = Alignment.center}) {
    return Align(
      alignment: alignment,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.md,
        children: [...actions],
      ),
    );
  }

  Widget _buildLeading({bool centered = false}) {
    if (leading == null) return const SizedBox.shrink();

    return centered ? Center(child: leading!) : leading!;
  }

  Widget _buildNavLinks({bool horizontal = true}) {
    if (links.isEmpty) return const SizedBox.shrink();

    return horizontal
        ? Row(
          children: [
            for (int i = 0; i < links.length; i++) ...[
              SFNavLinkItem(link: links[i]),
              if (i < links.length - 1) SizedBox(width: AppSpacing.sm),
            ],
          ],
        )
        : const SizedBox.shrink();
  }

  Widget _buildDesktopLayout() {
    return Row(
      spacing: AppSpacing.md,
      children: [
        _buildLeading(),
        Expanded(child: _buildNavLinks()),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildMobileLayout(Color backgroundColor) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        SFNavBarMobile(
          links: links,
          backgroundColor: backgroundColor,
          height: preferredSize.height,
        ),
        _buildLeading(centered: true),
        _buildActionButtons(alignment: Alignment.centerRight),
      ],
    );
  }
}
