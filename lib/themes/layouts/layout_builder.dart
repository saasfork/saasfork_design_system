import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SFLayoutBuilder {
  /// Widget à afficher en haut de la page (header/appbar)
  final Widget Function(BuildContext, WidgetRef)? headerBuilder;

  /// Widget à afficher comme contenu principal
  final Widget Function(BuildContext, WidgetRef) contentBuilder;

  /// Widget à afficher en bas de la page (footer)
  final Widget Function(BuildContext, WidgetRef)? footerBuilder;

  /// Widget à afficher dans le tiroir de navigation (drawer)
  final Widget Function(BuildContext, WidgetRef)? drawerBuilder;

  const SFLayoutBuilder({
    required this.contentBuilder,
    this.headerBuilder,
    this.footerBuilder,
    this.drawerBuilder,
  });
}
