import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:saasfork_design_system/utils/implementations/images/image_service_loader.dart';
import 'package:saasfork_design_system/utils/implementations/images/image_source.dart';
import 'package:signals/signals_flutter.dart';

class ImageSquare extends StatefulWidget {
  final XFileImageSource? imageFile;
  final double size;
  final ComponentSize radius;
  final ImageLoaderService? imageLoader;

  const ImageSquare({
    super.key,
    required this.size,
    this.imageFile,
    this.radius = ComponentSize.md,
    this.imageLoader,
  });

  @override
  State<ImageSquare> createState() => _ImageSquareState();
}

class _ImageSquareState extends State<ImageSquare> {
  late final ImageLoaderService _imageLoader;
  final _imageBytes = signal<Uint8List?>(null);
  String? _lastImagePath;

  @override
  void initState() {
    super.initState();
    _imageLoader = widget.imageLoader ?? ImageLoaderService();
    _loadImageBytes();
  }

  @override
  void didUpdateWidget(ImageSquare oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newPath = widget.imageFile?.file?.path;
    if (widget.imageFile != oldWidget.imageFile || newPath != _lastImagePath) {
      _loadImageBytes();
    }
  }

  Future<void> _loadImageBytes() async {
    if (widget.imageFile == null) {
      _imageBytes.value = null;
      _lastImagePath = null;
      return;
    }

    _lastImagePath = widget.imageFile?.file?.path;

    if (!kIsWeb) {
      // Sur les plateformes non-web, pas besoin de charger les bytes
      // car on utilise Image.file directement
      return;
    }

    try {
      _imageBytes.value = await _imageLoader.loadImageBytes(widget.imageFile!);
    } catch (e) {
      debugPrint('Erreur lors du chargement de l\'image: $e');
      _imageBytes.value = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      final imageData = _imageBytes.value;
      final filePath = widget.imageFile?.file?.path;
      Widget content;

      if (widget.imageFile == null) {
        content = _buildPlaceholder();
      } else if (kIsWeb) {
        content =
            imageData != null
                ? _buildMemoryImage(imageData)
                : _buildPlaceholder();
      } else {
        if (filePath != null) {
          content = _buildFileImage(filePath);
        } else {
          content = _buildPlaceholder();
        }
      }

      return ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.getRadius(widget.radius)),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: content,
        ),
      );
    });
  }

  Widget _buildPlaceholder() {
    return Container(
      key: const ValueKey('placeholder'),
      width: widget.size,
      height: widget.size,
      color: AppColors.gray.s50,
      child: Icon(Icons.image, color: AppColors.gray.s400),
    );
  }

  Widget _buildMemoryImage(Uint8List data) {
    return Image.memory(
      data,
      key: ValueKey('memory_image_${data.hashCode}'),
      width: widget.size,
      height: widget.size,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Erreur d\'affichage de l\'image: $error');
        return _buildErrorPlaceholder();
      },
    );
  }

  Widget _buildFileImage(String path) {
    return Image.file(
      File(path),
      key: ValueKey('file_image_$path'),
      width: widget.size,
      height: widget.size,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return _buildErrorPlaceholder();
      },
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      key: const ValueKey('error_placeholder'),
      width: widget.size,
      height: widget.size,
      color: AppColors.gray.s50,
      child: Icon(Icons.broken_image, color: AppColors.gray.s400),
    );
  }
}
