import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/foundations.dart';

class SFNotification extends StatelessWidget {
  final String? title;
  final String message;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onClose;

  const SFNotification({
    super.key,
    required this.message,
    required this.iconColor,
    this.title,
    this.icon = Icons.check_circle,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Positioned(
            top: AppSpacing.sm,
            right: AppSpacing.sm,
            child: IconButton(
              hoverColor: Colors.transparent,
              icon: Icon(
                Icons.close,
                size: AppSizes.getIconSize(ComponentSize.sm),
                color: AppColors.slate,
              ),
              onPressed: onClose,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppSpacing.xs,
                    right: AppSpacing.md,
                    left: AppSpacing.xs,
                  ),
                  child: Icon(icon, color: iconColor),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.xl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (title != null) ...[
                          Text(
                            title!,
                            style: Theme.of(context).textTheme.titleMedium,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          SizedBox(height: AppSpacing.sm),
                        ],
                        Text(
                          message,
                          style: Theme.of(context).textTheme.labelLarge,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
