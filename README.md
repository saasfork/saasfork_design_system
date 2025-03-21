# SaasFork Design System

Un système de design complet pour les applications Flutter de SaasFork, offrant des composants cohérents et réutilisables.

## Installation

```yaml
dependencies:
  saasfork_design_system:
    path: ../packages/saasfork_design_system
```

## Composants disponibles

### Atoms

Les éléments les plus basiques de notre système de design.

#### Boutons

SaasFork Design System offre plusieurs types de boutons pour différents contextes:

```dart
// Bouton principal
SFMainButton(
  label: 'Valider',
  onPressed: () => print('Bouton principal pressé'),
  size: ComponentSize.md, // xs, sm, md, lg, xl
  color: AppColors.primary, // Optionnel
);

// Bouton secondaire
SFSecondaryButton(
  label: 'Annuler',
  onPressed: () => print('Bouton secondaire pressé'),
  size: ComponentSize.md,
);

// Bouton lien
SFLinkButton(
  label: 'En savoir plus',
  onPressed: () => print('Lien pressé'),
  size: ComponentSize.md,
);

// Bouton circulaire
SFCircularButton(
  icon: Icons.add,
  onPressed: () => print('Bouton circulaire pressé'),
  size: ComponentSize.md,
  iconColor: Colors.white,
  backgroundColor: AppColors.primary, // Optionnel
);

// Bouton secondaire avec icône
SFSecondaryIconButton(
  icon: Icons.login,
  label: 'Se connecter',
  onPressed: () => print('Bouton avec icône pressé'),
);
```

#### Champs de texte

```dart
// Champ texte simple
SFTextField(
  placeholder: 'Votre email',
  controller: emailController,
  isInError: false,
  size: ComponentSize.md,
);

// Champ mot de passe
SFPasswordField(
  placeholder: 'Votre mot de passe',
  controller: passwordController,
  isInError: false,
  size: ComponentSize.md,
);
```

#### Icônes et séparateurs

```dart
// Icône stylisée
SFIcon(
  icon: Icons.warning,
  color: AppColors.warning,
  iconType: SFIconType.rounded,
);

// Séparateur avec texte
SFDividerWithText(text: 'ou continuer avec'),
```

### Molecules

Combinaisons d'atomes pour créer des composants plus complexes.

#### Champ de formulaire

```dart
SFFormfield(
  label: 'Email',
  isRequired: true,
  input: SFTextField(
    placeholder: 'Entrez votre email',
    controller: emailController,
    isInError: hasError,
  ),
  errorMessage: hasError ? 'Email invalide' : null,
  hintMessage: 'Nous ne partagerons jamais votre email',
);
```

#### Notifications

```dart
// Dans votre widget
SFNotification(
  title: 'Succès',
  message: 'Votre profil a été mis à jour',
  icon: Icons.check_circle_outline_rounded,
  iconColor: AppColors.success,
  onClose: () => print('Notification fermée'),
);

// Ou avec les extensions (plus simple)
context.showSuccess(
  title: 'Enregistré',
  message: 'Vos modifications ont été enregistrées',
);

context.showError(
  title: 'Erreur',
  message: 'Impossible de se connecter au serveur',
);

context.showInfo(
  message: 'Une mise à jour est disponible',
);

context.showWarning(
  title: 'Attention',
  message: 'Votre abonnement expire bientôt',
);
```

#### Dialogs

```dart
showDialog(
  context: context,
  builder: (context) => SFDialog(
    title: 'Désactiver le compte',
    message: 'Êtes-vous sûr de vouloir désactiver votre compte? Cette action ne peut pas être annulée.',
    icon: Icons.warning_amber_rounded,
    onCancel: () => Navigator.of(context).pop(),
    onDeactivate: () {
      // Action de désactivation
      Navigator.of(context).pop();
    },
    additionalData: {
      'desactivate_button': 'Désactiver',
      'cancel_button': 'Annuler',
    },
  ),
);
```

### Organisms

Combinaisons de molécules pour créer des composants plus complexes.

#### Formulaires

```dart
// Formulaire de connexion
SFLoginForm(
  additionalData: {
    'label_email': 'Adresse e-mail',
    'placeholder_email': 'Entrez votre email',
    'error_email_invalid': 'Adresse email invalide',
    'label_password': 'Mot de passe',
    'placeholder_password': 'Entrez votre mot de passe',
    'error_password_length': 'Le mot de passe doit contenir au moins 6 caractères',
    'login_button': 'Se connecter',
  },
  onSubmit: (loginData) {
    // Traiter les données de connexion
    print('Email: ${loginData['email']}');
    print('Password: ${loginData['password']}');
  },
  size: ComponentSize.md,
);

// Formulaire d'inscription
SFRegisterForm(
  additionalData: {
    'label_email': 'Email',
    'placeholder_email': 'Entrez votre email',
    'error_email_invalid': 'Adresse email invalide',
    'label_password': 'Mot de passe',
    'placeholder_password': 'Créez un mot de passe',
    'error_password_length': 'Le mot de passe doit contenir au moins 6 caractères',
    'register_button': 'Créer un compte',
  },
  onSubmit: (registerData) {
    // Traiter les données d'inscription
  },
);

// Formulaire de profil
SFProfileForm(
  additionalData: {
    'label_email': 'E-mail',
    'placeholder_email': 'Entrez votre email',
    'error_email_invalid': 'Adresse email invalide',
    'label_username': 'Nom d\'utilisateur',
    'placeholder_username': 'Entrez votre nom d\'utilisateur',
    'error_username_required': 'Le nom d\'utilisateur est requis',
    'save_button': 'Enregistrer',
  },
  profileModel: ProfileModel(
    email: 'user@example.com',
    username: 'johndoe',
  ),
  onSubmit: (profileData) {
    // Traiter les données du profil
  },
);
```

### Views

Composants de niveau supérieur qui intègrent plusieurs organismes.

#### Vue d'authentification

```dart
SFAuthView(
  additionalData: AuthFormData(
    authNotAccount: AuthLinkData(
      text: "Vous n'avez pas encore de compte ? ",
      link: "S'inscrire",
    ),
    authAlreadyExists: AuthLinkData(
      text: "Vous avez déjà un compte ? ",
      link: "Se connecter",
    ),
    authForgotPassword: AuthLinkData(
      link: "Mot de passe oublié ?",
    ),
    dividerText: "ou continuer avec",
  ),
  onLogin: (loginModel) {
    // Traiter la connexion
    print('Email: ${loginModel.email}');
  },
  onRegister: (registerModel) {
    // Traiter l'inscription
    print('Email: ${registerModel.email}');
  },
  onForgotPassword: (forgotPasswordModel) {
    // Traiter la récupération de mot de passe
    print('Email: ${forgotPasswordModel.email}');
  },
  onGoogleConnect: () {
    // Connexion avec Google
  },
  onGithubConnect: () {
    // Connexion avec GitHub
  },
);
```

#### Vue de profil

```dart
SFProfileView(
  additionalData: ProfileFormData(
    // Personnalisation des libellés et messages
  ),
  profileModel: ProfileModel(
    email: 'user@example.com',
    username: 'johndoe',
  ),
  onSubmit: (profileModel) {
    // Traiter la mise à jour du profil
    print('Email mis à jour: ${profileModel.email}');
    print('Username mis à jour: ${profileModel.username}');
  },
  children: [
    // Widgets additionnels à afficher sous le formulaire de profil
    SFSecondaryButton(
      label: 'Déconnexion',
      onPressed: () => print('Déconnexion'),
    ),
  ],
);
```

## Services et Utilitaires

### Service de notifications

```dart
// Configuration du service
NotificationService.setInstance(
  NotificationService.internal(OverlayNotificationManager()),
);

// Utilisation directe du service
NotificationService().showNotification(
  context,
  SFNotification(
    title: 'Succès',
    message: 'Votre profil a été mis à jour',
    icon: Icons.check_circle_outline_rounded,
    iconColor: AppColors.success,
  ),
  duration: const Duration(seconds: 4),
  margin: const EdgeInsets.only(top: 16, right: 16),
);

// Fermer toutes les notifications
NotificationService().closeAllNotifications();

// Utilisation des extensions (recommandée)
context.showSuccess(
  title: 'Enregistré',
  message: 'Vos modifications ont été enregistrées',
);
```

## Thèmes

```dart
// Application du thème global
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.system, // ou .light ou .dark
  home: MyHomePage(),
);
```

## Layouts

SaasFork Design System fournit des layouts par défaut pour structurer vos applications de manière cohérente.

### Default Layouts

```dart
// Layout de base avec appbar, body et bottomBar
SFDefaultLayout(
  appBar: AppBar(title: Text('Mon application')),
  body: Center(child: Text('Contenu principal')),
  bottomBar: BottomNavigationBar(
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Paramètres'),
    ],
  ),
);
```

## Fondations

### Couleurs

```dart
// Utilisation des couleurs prédéfinies
Container(
  color: AppColors.primary,
  child: Text('Texte sur fond primaire'),
);

// Variations de couleurs
Text(
  'Message d\'erreur', 
  style: TextStyle(color: AppColors.red.s400),
),
```

### Espacements

```dart
// Utilisation des espacements standardisés
Padding(
  padding: const EdgeInsets.all(AppSpacing.md),
  child: Text('Texte avec padding moyen'),
);

// Dans un Column ou Row avec l'extension spacing
Column(
  spacing: AppSpacing.md, // Ajoute un espace standardisé entre les éléments
  children: [
    Text('Premier élément'),
    Text('Deuxième élément'),
    Text('Troisième élément'),
  ],
);
```

### Typographie

```dart
Text(
  'Titre principal',
  style: AppTypography.headlineLarge,
);

Text(
  'Corps de texte',
  style: AppTypography.bodyMedium,
);

// Typographie adaptative selon la taille du composant
Text(
  'Bouton',
  style: AppTypography.getScaledStyle(
    AppTypography.labelLarge, 
    ComponentSize.md,
  ),
);
```

## Contribution

Pour contribuer au design system, veuillez consulter notre guide de contribution et suivre nos conventions de codage.

## License

SaasFork Design System est la propriété de SaasFork. Tous droits réservés.