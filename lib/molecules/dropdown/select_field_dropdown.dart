import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SelectedFieldDropdown extends StatelessWidget {
  final SFDropdownOption? value;
  final ComponentSize size;
  final bool isError;
  final bool isOpen;

  const SelectedFieldDropdown({
    super.key,
    required this.size,
    required this.isError,
    required this.isOpen,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputPadding = AppSizes.getInputPadding(size);

    final textStyle = AppTypography.getScaledStyle(
      AppTypography.bodyLarge.copyWith(height: 1.2),
      size,
    );

    final borderColor =
        isError
            ? theme.inputDecorationTheme.errorBorder?.borderSide.color
            : isOpen
            ? theme.inputDecorationTheme.focusedBorder?.borderSide.color
            : theme.inputDecorationTheme.enabledBorder?.borderSide.color;

    return Container(
      padding: inputPadding,
      constraints: BoxConstraints(
        minHeight: AppSizes.getInputConstraints(size).minHeight,
      ),
      decoration: BoxDecoration(
        color: theme.inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular(AppTheme.defaultBorderRadius),
        border: Border.all(color: borderColor ?? AppColors.gray.s300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              value?.label ?? '',
              style: textStyle.copyWith(
                color:
                    value?.value.isEmpty ?? true
                        ? isError
                            ? theme
                                .inputDecorationTheme
                                .errorBorder
                                ?.borderSide
                                .color
                            : theme.inputDecorationTheme.hintStyle?.color
                        : theme.textTheme.bodyLarge?.color,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Icon(
            isOpen
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
            color: theme.iconTheme.color,
            size: AppSizes.getIconSize(size),
          ),
        ],
      ),
    );
  }
}
