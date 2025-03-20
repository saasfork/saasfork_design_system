/// Données pour les textes du formulaire de profil
class ProfileFormData {
  /// Labels pour les champs
  final String labelUsername;
  final String labelEmail;

  /// Placeholders pour les champs
  final String placeholderUsername;
  final String placeholderEmail;

  /// Messages d'erreur
  final String errorUsernameRequired;
  final String errorEmailInvalid;

  /// Textes des boutons
  final String saveButton;
  final String logoutButton;
  final String deleteButton;

  const ProfileFormData({
    required this.labelUsername,
    required this.labelEmail,
    required this.placeholderUsername,
    required this.placeholderEmail,
    required this.errorUsernameRequired,
    required this.errorEmailInvalid,
    required this.saveButton,
    required this.logoutButton,
    required this.deleteButton,
  });

  /// Convertit les données en Map pour la compatibilité avec le code existant
  Map<String, dynamic> toMap() {
    return {
      'label_username': labelUsername,
      'label_email': labelEmail,
      'placeholder_username': placeholderUsername,
      'placeholder_email': placeholderEmail,
      'error_username_required': errorUsernameRequired,
      'error_email_invalid': errorEmailInvalid,
      'save_button': saveButton,
      'logout_button': logoutButton,
      'delete_button': deleteButton,
    };
  }
}
