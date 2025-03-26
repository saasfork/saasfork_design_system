import 'package:flutter/foundation.dart';
import 'package:saasfork_core/saasfork_core.dart';
import 'package:saasfork_design_system/utils/implementations/images/image_source.dart';

class ImageLoaderService {
  ImageLoaderService();

  Future<Uint8List?> loadImageBytes(ImageSource source) async {
    if (!source.isValid) return null;

    try {
      return await compute<ImageSource, Uint8List?>(
        (source) => source.getBytes(),
        source,
      );
    } catch (e) {
      error('Erreur lors du chargement de l\'image: $e');
      return null;
    }
  }
}
