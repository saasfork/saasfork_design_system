import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:saasfork_design_system/utils/implementations/images/image_service_loader.dart';
import 'package:saasfork_design_system/utils/implementations/images/image_source.dart';
import 'package:signals/signals_flutter.dart';

/// Widget abstrait pour l'affichage d'images à partir de différentes sources.
///
/// Ce widget sert de base pour l'implémentation de divers widgets d'affichage d'images
/// dans l'application. Il prend en charge les images à partir d'URL, de fichiers locaux
/// et gère les cas spécifiques à la plateforme web.
abstract class AbstractImageWidget extends StatefulWidget {
  /// Source de l'image à afficher.
  /// Peut être null, auquel cas un placeholder sera affiché.
  final ImageSource? imageSource;

  /// Service de chargement d'image personnalisé.
  /// Si non fourni, un service par défaut sera utilisé.
  final ImageLoaderService? imageLoader;

  const AbstractImageWidget({
    super.key,
    required this.imageSource,
    this.imageLoader,
  });
}

/// État abstrait pour gérer le comportement des widgets d'image.
///
/// Gère le chargement des données d'image et la logique d'affichage en fonction
/// de la source d'image et de la plateforme d'exécution.
abstract class AbstractImageWidgetState<T extends AbstractImageWidget>
    extends State<T> {
  /// Service de chargement d'images utilisé pour récupérer les données binaires
  late final ImageLoaderService _imageLoader;

  /// Signal contenant les données binaires de l'image chargée
  final _imageBytes = signal<Uint8List?>(null);

  /// Garde le chemin de la dernière image chargée pour éviter les rechargements inutiles
  String? _lastImagePath;

  @override
  void initState() {
    super.initState();
    _imageLoader = widget.imageLoader ?? ImageLoaderService();
    _loadImageBytes();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newPath = widget.imageSource?.path;
    if (widget.imageSource != oldWidget.imageSource ||
        newPath != _lastImagePath) {
      _loadImageBytes();
    }
  }

  /// Charge les données binaires de l'image à partir de la source spécifiée.
  ///
  /// Cette méthode est automatiquement appelée lors de l'initialisation et
  /// lorsque la source de l'image change. Elle gère différemment les images selon
  /// qu'elles proviennent d'une URL ou d'un fichier, et tient compte des spécificités web.
  Future<void> _loadImageBytes() async {
    if (widget.imageSource == null) {
      _imageBytes.value = null;
      _lastImagePath = null;
      return;
    }

    _lastImagePath = widget.imageSource?.path;

    final isUrl = widget.imageSource is UrlImageSource;
    if (isUrl || kIsWeb) {
      try {
        _imageBytes.value = await _imageLoader.loadImageBytes(
          widget.imageSource!,
        );
      } catch (e) {
        debugPrint('Erreur lors du chargement de l\'image: $e');
        _imageBytes.value = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      final imageData = _imageBytes.value;
      final path = widget.imageSource?.path;
      Widget content;

      if (widget.imageSource == null || !widget.imageSource!.isValid) {
        content = buildPlaceholder();
      } else if (widget.imageSource is UrlImageSource) {
        if (imageData != null) {
          content = buildMemoryImage(imageData);
        } else {
          content = buildNetworkImage(path!);
        }
      } else if (kIsWeb) {
        content =
            imageData != null
                ? buildMemoryImage(imageData)
                : buildPlaceholder();
      } else {
        if (path != null && widget.imageSource is XFileImageSource) {
          content = buildFileImage(path);
        } else {
          content = buildPlaceholder();
        }
      }

      return buildClippedContainer(
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: content,
        ),
      );
    });
  }

  /// Construit le conteneur qui appliquera le style de découpage (cliping) à l'image.
  /// À implémenter par les sous-classes.
  Widget buildClippedContainer(Widget child);

  /// Construit un widget d'image à partir de données binaires en mémoire.
  /// À implémenter par les sous-classes.
  Widget buildMemoryImage(Uint8List data);

  /// Construit un widget d'image à partir d'un chemin de fichier local.
  /// À implémenter par les sous-classes.
  Widget buildFileImage(String path);

  /// Construit un widget d'image à partir d'une URL.
  /// À implémenter par les sous-classes.
  Widget buildNetworkImage(String url);

  /// Construit un widget placeholder quand aucune image n'est disponible.
  /// À implémenter par les sous-classes.
  Widget buildPlaceholder();

  /// Construit un widget placeholder en cas d'erreur de chargement.
  /// À implémenter par les sous-classes.
  Widget buildErrorPlaceholder();

  /// Renvoie la taille attendue de l'image.
  /// À implémenter par les sous-classes.
  double getSize();
}
