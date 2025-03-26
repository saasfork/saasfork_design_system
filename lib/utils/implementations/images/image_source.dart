// Créer une interface pour les sources d'images
import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';

abstract class ImageSource {
  Future<Uint8List?> getBytes();
  String? get path;
  bool get isValid;
}

// Implémentation pour XFile
class XFileImageSource implements ImageSource {
  final XFile? file;

  XFileImageSource(this.file);

  @override
  Future<Uint8List?> getBytes() async {
    if (file == null) return null;
    return Uint8List.fromList(await file!.readAsBytes());
  }

  @override
  String? get path => file?.path;

  @override
  bool get isValid => file != null;
}
