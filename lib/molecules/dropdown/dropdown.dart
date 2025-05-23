import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:signals/signals_flutter.dart';

class SFDropdown extends StatefulWidget {
  final List<SFDropdownOption> options;
  final String? selectedValue;
  final ValueChanged<String> onChanged;
  final String placeholder;
  final ComponentSize size;
  final bool isError;
  final double? width;
  final Widget Function(BuildContext, SFDropdownOption value, bool isOpen)
  builder;

  const SFDropdown({
    super.key,
    required this.options,
    required this.onChanged,
    this.selectedValue,
    this.placeholder = "Select an option",
    this.size = ComponentSize.md,
    this.isError = false,
    this.width, // Ajout dans le constructeur
    required this.builder,
  });

  @override
  State<SFDropdown> createState() => _SFDropdownState();
}

class _SFDropdownState extends State<SFDropdown> with SignalsMixin {
  final GlobalKey _dropdownKey = GlobalKey();
  late final _isOpen = createSignal(false);
  double _dropdownWidth = 0;

  @override
  void initState() {
    super.initState();

    // Si une largeur personnalisée est fournie, l'utiliser directement
    if (widget.width != null) {
      _dropdownWidth = widget.width!;
    } else {
      // Sinon, mesurer la taille du widget après le rendu
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final RenderBox? renderBox =
            _dropdownKey.currentContext?.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          setState(() {
            _dropdownWidth = renderBox.size.width;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedOption = widget.options.firstWhere(
      (option) => option.value == widget.selectedValue,
      orElse: () => SFDropdownOption(label: widget.placeholder, value: ''),
    );

    return PopupMenuButton<String>(
      key: _dropdownKey,
      onOpened: () {
        _isOpen.value = true;
      },
      onCanceled: () {
        _isOpen.value = false;
      },
      onSelected: (String value) {
        widget.onChanged(value);
        _isOpen.value = false;
      },
      tooltip: '',
      elevation: 4,
      position: PopupMenuPosition.under,
      constraints: BoxConstraints(
        minWidth: widget.width ?? _dropdownWidth,
        maxWidth: widget.width ?? _dropdownWidth,
      ),
      offset: const Offset(0, AppSpacing.sm),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.defaultBorderRadius),
      ),
      itemBuilder: (BuildContext context) {
        return widget.options.map((option) {
          final isSelected = widget.selectedValue == option.value;
          final optionTextStyle = AppTypography.getScaledStyle(
            AppTypography.bodyLarge,
            widget.size,
          );

          return PopupMenuItem<String>(
            value: option.value,
            child: SizedBox(
              width: double.infinity,
              child: Text(
                option.label,
                style: optionTextStyle.copyWith(
                  color:
                      isSelected
                          ? theme.colorScheme.primary
                          : theme.textTheme.bodyLarge?.color,
                ),
              ),
            ),
          );
        }).toList();
      },
      child: widget.builder(context, selectedOption, _isOpen.value),
    );
  }
}
