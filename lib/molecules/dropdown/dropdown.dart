import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:signals/signals_flutter.dart';

class SFDropdown extends StatefulWidget {
  final List<DropdownOption> options;
  final String? selectedValue;
  final ValueChanged<String> onChanged;
  final String placeholder;
  final ComponentSize size;
  final bool isError;

  const SFDropdown({
    super.key,
    required this.options,
    required this.onChanged,
    this.selectedValue,
    this.placeholder = "Select an option",
    this.size = ComponentSize.md,
    this.isError = false,
  });

  @override
  State<SFDropdown> createState() => _SFDropdownState();
}

class _SFDropdownState extends State<SFDropdown>
    with SignalsMixin, SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  late final _isOpen = createSignal(false);
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isOpen.value) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _isOpen.value = true;
    _animationController.forward(from: 0.0);
  }

  void _closeDropdown() {
    _animationController.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isOpen.value = false;
    });
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final theme = Theme.of(context);

    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _closeDropdown,
                child: Container(color: Colors.transparent),
              ),
            ),
            Positioned(
              width: size.width,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _animationController.value,
                    child: Transform.translate(
                      offset: Offset(0, (1 - _animationController.value) * -20),
                      child: child,
                    ),
                  );
                },
                child: CompositedTransformFollower(
                  link: _layerLink,
                  offset: Offset(0, size.height + AppSpacing.sm),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(
                      AppTheme.defaultBorderRadius,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.inputDecorationTheme.fillColor,
                        borderRadius: BorderRadius.circular(
                          AppTheme.defaultBorderRadius,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.grey.s50,
                            blurRadius: AppSpacing.md,
                            offset: Offset(0, AppSpacing.xs),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppTheme.defaultBorderRadius,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:
                              widget.options.map((option) {
                                final isSelected =
                                    widget.selectedValue == option.value;
                                final textStyle = AppTypography.getScaledStyle(
                                  AppTypography.bodyLarge,
                                  widget.size,
                                );

                                return Material(
                                  color:
                                      isSelected
                                          ? theme.colorScheme.primary.withAlpha(
                                            10,
                                          )
                                          : theme
                                              .inputDecorationTheme
                                              .fillColor,
                                  child: InkWell(
                                    onTap: () {
                                      widget.onChanged(option.value);
                                      _closeDropdown();
                                    },
                                    hoverColor: AppColors.gray.s100,
                                    splashColor: AppColors.gray.s200,
                                    highlightColor: AppColors.gray.s100,
                                    child: Container(
                                      width: double.infinity,
                                      padding: AppSizes.getInputPadding(
                                        widget.size,
                                      ),
                                      height:
                                          AppSizes.getInputConstraints(
                                            widget.size,
                                          ).minHeight,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          option.label,
                                          style: textStyle.copyWith(
                                            color:
                                                isSelected
                                                    ? theme.colorScheme.primary
                                                    : theme
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.color,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedOption = widget.options.firstWhere(
      (option) => option.value == widget.selectedValue,
      orElse: () => DropdownOption(label: widget.placeholder, value: ''),
    );

    final theme = Theme.of(context);
    final textStyle = AppTypography.getScaledStyle(
      AppTypography.bodyLarge.copyWith(height: 1.2),
      widget.size,
    );

    final borderColor =
        widget.isError
            ? theme.inputDecorationTheme.errorBorder?.borderSide.color
            : _isOpen.value
            ? theme.inputDecorationTheme.focusedBorder?.borderSide.color
            : theme.inputDecorationTheme.enabledBorder?.borderSide.color;

    final inputPadding = AppSizes.getInputPadding(widget.size);

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: inputPadding,
          constraints: BoxConstraints(
            minHeight: AppSizes.getInputConstraints(widget.size).minHeight,
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
                  selectedOption.label,
                  style: textStyle.copyWith(
                    color:
                        selectedOption.value.isEmpty
                            ? widget.isError
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
                _isOpen.value
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                color: theme.iconTheme.color,
                size: AppSizes.getIconSize(widget.size),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
