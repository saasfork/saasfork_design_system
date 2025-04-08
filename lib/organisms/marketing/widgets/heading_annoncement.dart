import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:signals/signals_flutter.dart';

class SFHeadingAnnouncement extends StatefulWidget {
  final String label;
  final String? ctaLabel;
  final Color? colorSeeMore;
  final VoidCallback? onPressed;

  const SFHeadingAnnouncement({
    super.key,
    required this.label,
    this.ctaLabel,
    this.colorSeeMore,
    this.onPressed,
  });

  @override
  State<SFHeadingAnnouncement> createState() => _SFHeadingAnnouncementState();
}

class _SFHeadingAnnouncementState extends State<SFHeadingAnnouncement>
    with SignalsMixin {
  late final _isHover = createSignal<bool>(false);
  late Color _seeMore;

  @override
  Widget build(BuildContext context) {
    _seeMore = widget.colorSeeMore ?? Theme.of(context).primaryColor;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => _isHover.value = true,
      onExit: (event) => _isHover.value = false,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHover.value ? AppColors.gray.s200 : AppColors.grey.s100,
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${widget.label} ',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (widget.ctaLabel != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppSpacing.xs,
                  children: [
                    Text(
                      widget.ctaLabel!,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _seeMore,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: AppSpacing.md,
                      color: _seeMore,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
