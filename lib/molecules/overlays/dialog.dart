import 'package:flutter/material.dart';
import 'package:saasfork_design_system/atoms/atoms.dart';
import 'package:saasfork_design_system/foundations/foundations.dart';

class SFDialog extends StatelessWidget {
  final String title;
  final String message;
  final double width;
  final IconData? icon;
  final VoidCallback onCancel;
  final VoidCallback onDeactivate;
  final Map<String, String> additionalData;

  const SFDialog({
    super.key,
    required this.title,
    required this.message,
    this.width = 400,
    required this.onCancel,
    required this.onDeactivate,
    this.icon,
    this.additionalData = const {
      'desactivate_button': 'Deactivate',
      'cancel_button': 'Cancel',
    },
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final useVerticalLayout =
        screenWidth < 480; // Seuil pour basculer en affichage vertical

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
                      Text(
                        message,
                        style: AppTypography.bodyMedium,
                        softWrap: true,
                        textAlign:
                            !useVerticalLayout
                                ? TextAlign.start
                                : TextAlign.center,
                      ),
                    ],
                  ),
                  if (useVerticalLayout)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: AppSpacing.md,
                      children: [
                        SFMainButton(
                          label:
                              additionalData['desactivate_button'] ??
                              'Deactivate',
                          color: AppColors.danger,
                          onPressed: onDeactivate,
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
                              additionalData['desactivate_button'] ??
                              'Deactivate',
                          color: AppColors.danger,
                          onPressed: onDeactivate,
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
