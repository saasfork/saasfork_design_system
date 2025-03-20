import 'package:flutter/material.dart';

/// Interface pour la traduction
abstract class AppLocalizations {
  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations) ??
      GeneratedLocalizations(context);

  /// Méthode pour obtenir une traduction
  String translate(String key, {Map<String, String>? args});
}

/// Implémentation qui récupère dynamiquement les traductions de `S`
class GeneratedLocalizations implements AppLocalizations {
  final context;

  GeneratedLocalizations(this.context);

  @override
  String translate(String key, {Map<String, String>? args}) {
    final dynamic localization = Localizations.of(context, Object);

    if (localization == null) {
      return key;
    }

    try {
      // Vérifie si l'instance possède la clé sous forme de getter et l'appelle dynamiquement
      final dynamic translated = (localization as dynamic).noSuchMethod(
        Invocation.getter(Symbol(key)),
        returnValue: null,
      );

      if (translated is String) {
        String translation = translated;

        // Remplacement des variables dynamiques dans la traduction
        args?.forEach((argKey, argValue) {
          translation = translation.replaceAll('{$argKey}', argValue);
        });

        return translation;
      }
    } catch (e) {
      debugPrint("[DEBUG] Erreur lors de la récupération de la clé $key : $e");
    }

    return key; // Retourne la clé brute si aucune traduction n'est trouvée
  }
}

/// Implémentation par défaut si `Localizations` n'est pas disponible
class EmptyLocalizations implements AppLocalizations {
  const EmptyLocalizations();

  @override
  String translate(String key, {Map<String, String>? args}) => key;
}
