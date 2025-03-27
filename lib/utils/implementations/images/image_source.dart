import 'dart:typed_data';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:saasfork_core/saasfork_core.dart';

abstract class ImageSource {
  Future<Uint8List?> getBytes();
  String? get path;
  bool get isValid;
}

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

class UrlImageSource implements ImageSource {
  final String? url;

  UrlImageSource(this.url);

  @override
  Future<Uint8List?> getBytes() async {
    if (url == null || url!.isEmpty) return null;

    try {
      final response = await http.get(Uri.parse(url!));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
      return null;
    } catch (e) {
      error('Erreur lors du téléchargement de l\'image: $e');
      return null;
    }
  }

  @override
  String? get path => url;

  @override
  bool get isValid => url != null && url!.isNotEmpty;
}
