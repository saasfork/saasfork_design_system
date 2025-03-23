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

### Système Responsive

Notre système responsive permet d'adapter facilement vos layouts à différentes tailles d'écran.

#### Grille Responsive

```dart
// Une grille qui adapte automatiquement le nombre de colonnes selon la taille d'écran
ResponsiveGrid(
  // Surcharger le nombre de colonnes par défaut par type d'écran (optionnel)
  mobileColumns: 1,
  tabletColumns: 2,
  desktopColumns: 3,
  largeDesktopColumns: 4,
  
  // Espacements et marges
  spacing: 16.0,
  margin: EdgeInsets.all(16.0),
  padding: EdgeInsets.all(8.0),
  
  // Contenu de la grille
  children: [
    // Vos widgets ici
    Card(child: Text("Élément 1")),
    Card(child: Text("Élément 2")),
    Card(child: Text("Élément 3")),
  ],
);
```

#### Lignes et Colonnes Responsives

```dart
// Création d'une ligne responsive avec des colonnes
ResponsiveRow(
  spacing: 16.0,
  wrap: true, // Passe à la ligne si l'espace est insuffisant
  margin: EdgeInsets.symmetric(vertical: 16.0),
  children: [
    // Colonne responsive qui occupe 6/12 sur mobile, 4/12 sur tablet, 3/12 sur desktop
    ResponsiveColumn(
      xs: 6, // Mobile (fraction sur 12)
      sm: 4, // Tablet (fraction sur 12)
      md: 3, // Desktop (fraction sur 12)
      child: Container(color: Colors.red, height: 100),
    ),
    
    // Colonne responsive qui occupe 6/12 sur mobile, 8/12 sur tablet, 9/12 sur desktop
    ResponsiveColumn(
      xs: 6,
      sm: 8,
      md: 9,
      padding: EdgeInsets.all(8.0),
      child: Container(color: Colors.blue, height: 100),
    ),
  ],
);
```

#### Conteneur Responsive

```dart
// Conteneur responsive qui s'adapte selon la taille d'écran
ResponsiveContainer(
  maxWidth: 1200.0, // Largeur max (optionnel)
  padding: EdgeInsets.all(16.0), // Padding adapté automatiquement sur mobile
  center: true, // Centre le contenu si maxWidth est défini
  child: Text("Contenu centré avec largeur maximale"),
);
```

#### Extensions Responsives

```dart
// Détecter la taille d'écran actuelle
if (context.isMobile) {
  // Logique spécifique aux mobiles
} else if (context.isTablet) {
  // Logique spécifique aux tablettes
} else if (context.isDesktop) {
  // Logique spécifique aux desktops
}

// Valeur adaptative selon la taille d'écran
final padding = context.responsive(
  mobile: 8.0,
  tablet: 16.0,
  desktop: 24.0,
  largeDesktop: 32.0,
);

// Accéder aux marges et espacements adaptés
final horizontalMargin = context.horizontalMargin;
final gap = context.gap;

// Padding adapté à la taille d'écran
Container(
  padding: context.responsivePadding, // Padding horizontal & vertical
  child: Text("Contenu avec padding adaptatif"),
);

// Nombre de colonnes de la grille actuelle
final columns = context.columns; // 1-12 selon la taille d'écran
```

## Contribution

Pour contribuer au design system, veuillez consulter notre guide de contribution et suivre nos conventions de codage.

## License

SaasFork Design System est la propriété de SaasFork. Tous droits réservés.