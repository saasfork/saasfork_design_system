import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:saasfork_design_system/utils/expected_file.dart';
import 'package:signals/signals_flutter.dart';

class SFFileField extends StatefulWidget {
  final String label;
  final ComponentSize size;
  final List<ExpectedFileType> expectedFiles;
  final List<XFile>? initialFiles;
  final int? maxFiles;
  final bool disabled;
  final Function(List<XFile>) onPressed;
  final Function(dynamic)? onError;

  const SFFileField({
    required this.onPressed,
    this.onError,
    this.size = ComponentSize.md,
    this.expectedFiles = const [],
    required this.label,
    this.initialFiles = const [],
    this.maxFiles,
    this.disabled = false,
    super.key,
  });

  @override
  State<SFFileField> createState() => _SFFileFieldState();
}

class _SFFileFieldState extends State<SFFileField> {
  final _selectedFiles = signal<List<XFile>>([]);

  @override
  void initState() {
    super.initState();
    _selectedFiles.value = widget.initialFiles ?? [];
  }

  @override
  void didUpdateWidget(SFFileField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialFiles != oldWidget.initialFiles) {
      _selectedFiles.value = widget.initialFiles ?? [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SFMainButton(
      label: widget.label,
      size: widget.size,
      onPressed: _handleFileSelection,
      disabled: widget.disabled,
    );
  }

  void _handleFileSelection() async {
    try {
      if (widget.maxFiles != null &&
          _selectedFiles.value.length >= widget.maxFiles!) {
        if (widget.onError != null) {
          widget.onError!(
            "Maximum number of files reached (${widget.maxFiles})",
          );
        }
        return;
      }

      FileType fileType = FileType.any;
      List<String>? allowedExtensions;

      if (widget.expectedFiles.isNotEmpty) {
        final allSameType = widget.expectedFiles.every(
          (type) => type.fileType == widget.expectedFiles.first.fileType,
        );

        if (allSameType) {
          fileType = widget.expectedFiles.first.fileType;
        }
      }

      int? maxFilesToSelect;
      if (widget.maxFiles != null) {
        maxFilesToSelect = widget.maxFiles! - _selectedFiles.value.length;
        if (maxFilesToSelect <= 0) return;
      }

      final result = await FilePicker.platform.pickFiles(
        type: fileType,
        allowedExtensions: allowedExtensions,
        allowMultiple: widget.maxFiles == null || maxFilesToSelect! > 1,
      );

      if (result != null) {
        final newFiles =
            result.files
                .map((file) => XFile(file.path ?? '', name: file.name))
                .toList();

        if (widget.maxFiles != null) {
          final remainingSlots = widget.maxFiles! - _selectedFiles.value.length;
          if (newFiles.length > remainingSlots) {
            newFiles.removeRange(remainingSlots, newFiles.length);
            if (widget.onError != null) {
              widget.onError!(
                "Only the first $remainingSlots files were added to respect the limit",
              );
            }
          }
        }

        final updatedFiles = List<XFile>.from(_selectedFiles.value);
        updatedFiles.addAll(newFiles);
        _selectedFiles.value = updatedFiles;

        widget.onPressed(_selectedFiles.value);
      }
    } catch (error) {
      if (widget.onError != null) {
        widget.onError!(error);
      }
    }
  }
}
