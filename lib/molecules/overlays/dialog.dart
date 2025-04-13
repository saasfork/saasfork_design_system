import 'package:flutter/material.dart';
import 'package:saasfork_design_system/atoms/atoms.dart';
import 'package:saasfork_design_system/foundations/foundations.dart';

class SFDialog extends StatelessWidget {
  final String title;
  final String? message;
  final Widget? messageWidget;
  final double width;
  final IconData? icon;
  final VoidCallback onCancel;
  final VoidCallback onAction;
  final Color? actionButtonColor;
  final Map<String, String> additionalData;

  const SFDialog({
    super.key,
    required this.title,
    this.message,
    this.messageWidget,
    this.width = 400,
    required this.onCancel,
    required this.onAction,
    this.icon,
    this.additionalData = const {
      'action_button': 'Deactivate',
      'cancel_button': 'Cancel',
    },
    this.actionButtonColor,
  });

  @override
  Widget build(BuildContext context) {
    assert(
      message != null || messageWidget != null,
      'Either message or messageWidget must be provided.',
    );

    final screenWidth = MediaQuery.of(context).size.width;
    final useVerticalLayout = screenWidth < 480;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
      ),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.lg,
          children: [
            if (icon != null && !useVerticalLayout)
              SFIcon(
                icon: icon!,
                color: AppColors.danger,
                iconType: SFIconType.rounded,
              ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    !useVerticalLayout
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                spacing: AppSpacing.md,
                children: [
                  if (icon != null && useVerticalLayout)
                    SFIcon(
                      icon: icon!,
                      color: AppColors.danger,
                      iconType: SFIconType.rounded,
                    ),
                  Column(
                    crossAxisAlignment:
                        !useVerticalLayout
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                    spacing: AppSpacing.sm,
                    children: [
                      Text(
                        title,
                        style: AppTypography.headlineMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign:
                            !useVerticalLayout
                                ? TextAlign.start
                                : TextAlign.center,
                      ),
                      if (message != null && message!.isNotEmpty)
                        Text(
                          message!,
                          style: AppTypography.bodyMedium,
                          softWrap: true,
                          textAlign:
                              !useVerticalLayout
                                  ? TextAlign.start
                                  : TextAlign.center,
                        ),
                      if (messageWidget != null) messageWidget!,
                    ],
                  ),
                  if (useVerticalLayout)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: AppSpacing.md,
                      children: [
                        SFMainButton(
                          label:
                              additionalData['action_button'] ?? 'Deactivate',
                          color: actionButtonColor ?? AppColors.danger,
                          onPressed: onAction,
                        ),
                        SFSecondaryButton(
                          label: additionalData['cancel_button'] ?? 'Cancel',
                          onPressed: onCancel,
                        ),
                      ],
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: AppSpacing.md,
                      children: [
                        SFSecondaryButton(
                          label: additionalData['cancel_button'] ?? 'Cancel',
                          onPressed: onCancel,
                        ),
                        SFMainButton(
                          label:
                              additionalData['action_button'] ?? 'Deactivate',
                          color: actionButtonColor ?? AppColors.danger,
                          onPressed: onAction,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
