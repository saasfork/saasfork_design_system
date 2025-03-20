import 'package:reactive_forms/reactive_forms.dart';

class FormUtils {
  /// Vérifie si un formulaire est valide
  ///
  /// Cette méthode marque tous les champs comme touchés pour forcer l'affichage
  /// des erreurs, puis vérifie si le formulaire est valide selon les règles
  /// définies par reactive_forms et par une logique personnalisée additionnelle.
  ///
  /// [form] Le FormGroup à valider
  /// [setState] Fonction optionnelle pour rafraîchir l'UI après avoir marqué les champs comme touchés
  ///
  /// Retourne true si le formulaire est valide, false sinon
  static bool isFormValid(FormGroup form, {Function()? setState}) {
    // Marquer tous les champs comme touchés pour afficher les erreurs
    form.markAllAsTouched();

    // Rafraîchir l'UI si nécessaire
    if (setState != null) {
      setState();
    }

    // Si le formulaire est valide selon reactive_forms, retourner true immédiatement
    if (form.valid) {
      return true;
    }

    // À ce stade, on sait que le formulaire est invalide
    // On pourrait simplement retourner false, mais nous allons continuer
    // avec le traitement détaillé pour la compatibilité avec le code existant

    // Vérifier chaque contrôle individuellement
    bool allValid = true;

    form.controls.forEach((key, control) {
      // Si le contrôle est invalide
      if (!control.valid) {
        // Traiter les formulaires imbriqués (FormGroup)
        if (control is FormGroup) {
          // Vérifier récursivement le formulaire imbriqué
          if (!isFormValid(control)) {
            allValid = false;
            return; // Sortir de l'itération
          }
        }
        // Traiter les champs normaux
        else if (control.validators.isNotEmpty) {
          // Vérifier les validateurs
          if (control.validators.any(
            (validator) => validator == Validators.required,
          )) {
            if (control.value == null ||
                (control.value is String &&
                    (control.value as String).isEmpty)) {
              allValid = false;
              return;
            }
          }

          // Autres validateurs
          if (control.value != null &&
              (control.value is! String ||
                  (control.value as String).isNotEmpty)) {
            allValid = false;
          }
        }
      }
    });

    return allValid;
  }
}
