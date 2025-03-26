import 'package:flutter/material.dart';
import 'package:saasfork_design_system/foundations/colors.dart';

/// Un widget qui affiche un message d'erreur ou un indice pour les champs de formulaire.
///
/// Si un message d'erreur est fourni, il est affiché en rouge.
/// Sinon, le message d'indice est affiché en gris.
class SFFormMessage extends StatelessWidget {
  final String? errorMessage;
  final String? hintMessage;

  const SFFormMessage({super.key, this.errorMessage, this.hintMessage});

  @override
  Widget build(BuildContext context) {
    final hasError = errorMessage != null && errorMessage!.isNotEmpty;

    return Text(
      hasError ? errorMessage! : hintMessage ?? '',
      style: TextStyle(
        fontStyle: FontStyle.italic,
        color: hasError ? AppColors.red.s400 : AppColors.gray.s400,
      ),
    );
  }
}
