import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:saasfork_design_system/atoms/images/abstract_image.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFImageCircle extends AbstractImageWidget {
  final double diameter;

  const SFImageCircle({
    super.key,
    required this.diameter,
    super.imageSource,
    super.imageLoader,
  });

  @override
  State<SFImageCircle> createState() => _ImageCircleState();
}

class _ImageCircleState extends AbstractImageWidgetState<SFImageCircle> {
  @override
  Widget buildClippedContainer(Widget child) {
    return ClipOval(child: child);
  }

  @override
  Widget buildMemoryImage(Uint8List data) {
    return RepaintBoundary(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        child: Image.memory(
          data,
          key: ValueKey('memory_image_${data.hashCode}'),
          width: getSize(),
          height: getSize(),
          fit: BoxFit.cover,
          cacheWidth: getSize().toInt() * 2, // Pour écrans haute densité
          errorBuilder: (context, error, stackTrace) {
            debugPrint('Erreur d\'affichage de l\'image: $error');
            return buildErrorPlaceholder();
          },
        ),
      ),
    );
  }

  @override
  Widget buildFileImage(String path) {
    return Image.file(
      File(path),
      key: ValueKey('file_image_$path'),
      width: getSize(),
      height: getSize(),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return buildErrorPlaceholder();
      },
    );
  }

  @override
  Widget buildNetworkImage(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      key: ValueKey('network_image_$url'),
      width: getSize(),
      height: getSize(),
      fit: BoxFit.cover,
      filterQuality: FilterQuality.medium,
      placeholder:
          (context, url) => Container(
            width: getSize(),
            height: getSize(),
            color: Theme.of(context).colorScheme.primary.withAlpha(10),
          ),
      errorWidget: (context, url, error) {
        debugPrint('Erreur d\'affichage de l\'image réseau: $error');
        return buildErrorPlaceholder();
      },
    );
  }

  @override
  Widget buildPlaceholder() {
    return Container(
      key: const ValueKey('placeholder'),
      width: getSize(),
      height: getSize(),
      color: AppColors.gray.s50,
      child: Icon(
        Icons.person,
        color: AppColors.gray.s400,
        size: getSize() * 0.5,
      ),
    );
  }

  @override
  Widget buildErrorPlaceholder() {
    return Container(
      key: const ValueKey('error_placeholder'),
      width: getSize(),
      height: getSize(),
      color: Theme.of(context).colorScheme.primary.withAlpha(10),
      child: Icon(
        Icons.broken_image,
        color: Theme.of(context).colorScheme.onPrimary,
        size: getSize() * 0.5,
      ),
    );
  }

  @override
  double getSize() {
    return widget.diameter;
  }
}
