/// Données pour les textes d'authentification
class AuthFormData {
  /// Labels pour les champs
  final String labelEmail;
  final String labelPassword;

  /// Placeholders pour les champs
  final String placeholderEmail;
  final String placeholderPassword;

  /// Messages d'erreur
  final String errorEmailInvalid;
  final String errorPasswordLength;

  /// Textes des boutons
  final String loginButton;
  final String registerButton;
  final String forgotPasswordButton;

  /// Textes pour les liens
  final LinkTextPair authNotAccount;
  final LinkTextPair authForgotPassword;
  final LinkTextPair authAlreadyExists;

  /// Divider text used in the authentication view
  final String? dividerText;

  const AuthFormData({
    required this.labelEmail,
    required this.labelPassword,
    required this.placeholderEmail,
    required this.placeholderPassword,
    required this.errorEmailInvalid,
    required this.errorPasswordLength,
    required this.loginButton,
    required this.registerButton,
    required this.forgotPasswordButton,
    required this.authNotAccount,
    required this.authForgotPassword,
    required this.authAlreadyExists,
    this.dividerText,
  });

  /// Convertit les données en Map pour la compatibilité avec le code existant
  Map<String, dynamic> toMap() {
    return {
      'label_email': labelEmail,
      'placeholder_email': placeholderEmail,
      'error_email_invalid': errorEmailInvalid,
      'label_password': labelPassword,
      'placeholder_password': placeholderPassword,
      'error_password_length': errorPasswordLength,
      'login_button': loginButton,
      'register_button': registerButton,
      'forgot_password_button': forgotPasswordButton,
      'auth_not_account': authNotAccount.toMap(),
      'auth_forgot_password': authForgotPassword.toMap(),
      'auth_already_exists': authAlreadyExists.toMap(),
      'divider_text': dividerText,
    };
  }
}

/// Paire de textes pour les liens avec texte optionnel
class LinkTextPair {
  final String? text;
  final String link;

  const LinkTextPair({this.text, required this.link});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{'link': link};

    if (text != null) {
      map['text'] = text;
    }

    return map;
  }
}
