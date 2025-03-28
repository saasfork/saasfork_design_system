import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class AppTheme {
  // Constantes pour les valeurs fréquemment utilisées
  static const double defaultBorderRadius = AppSpacing.sm;
  static const double defaultElevation = 0.0;

  // Méthode utilitaire pour créer les bordures d'input
  static OutlineInputBorder _createInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(defaultBorderRadius),
      borderSide: BorderSide(color: color),
    );
  }

  // Méthode pour obtenir la couleur de fond du préfixe
  static Color getPrefixBackgroundColor(
    BuildContext context, {
    bool isError = false,
  }) {
    if (isError) {
      return AppColors.red.s50;
    }

    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light
        ? AppColors.gray.s50
        : AppColors.grey.s700;
  }

  // Styles pour les boutons élevés
  static ButtonStyle _createElevatedButtonStyle({
    required Color backgroundColor,
    required Color foregroundColor,
    BorderSide? side,
  }) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((_) => backgroundColor),
      foregroundColor: WidgetStateProperty.resolveWith(
        (states) =>
            backgroundColor == Colors.transparent ? null : foregroundColor,
      ),
      padding: WidgetStateProperty.all(AppSizes.getPadding(ComponentSize.md)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          side: side ?? BorderSide.none,
        ),
      ),
      textStyle: WidgetStateProperty.all(AppTypography.labelLarge),
      elevation: WidgetStateProperty.all(defaultElevation),
    );
  }

  // Styles pour les boutons avec contour
  static ButtonStyle _createOutlinedButtonStyle({
    required Color foregroundColor,
    required Color backgroundColor,
    BorderSide? side,
  }) {
    return ButtonStyle(
      foregroundColor: WidgetStateProperty.all(foregroundColor),
      backgroundColor: WidgetStateProperty.all(backgroundColor),
      padding: WidgetStateProperty.all(AppSizes.getPadding(ComponentSize.md)),
      textStyle: WidgetStateProperty.all(AppTypography.labelLarge),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          side: side ?? BorderSide.none,
        ),
      ),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return AppColors.gray.s50.withValues(alpha: .3);
        }
        if (states.contains(WidgetState.pressed)) {
          return AppColors.gray.s50;
        }
        return null;
      }),
    );
  }

  // Thème pour les décorations d'input
  static InputDecorationTheme _createInputDecorationTheme({
    required Color fillColor,
    required Color hintColor,
    required Color enabledBorderColor,
    required Color focusedBorderColor,
    required Color errorBorderColor,
    ComponentSize size = ComponentSize.md,
  }) {
    final baseTextStyle = AppTypography.getScaledStyle(
      AppTypography.bodyLarge,
      size,
    );

    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      hoverColor: Colors.transparent,
      hintStyle: baseTextStyle.copyWith(color: hintColor),
      enabledBorder: _createInputBorder(enabledBorderColor),
      focusedBorder: _createInputBorder(focusedBorderColor),
      errorBorder: _createInputBorder(errorBorderColor),
      focusedErrorBorder: _createInputBorder(errorBorderColor),
      // Adaptez les paddings en fonction de la taille
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical:
            size == ComponentSize.lg
                ? AppSpacing.md
                : (size == ComponentSize.sm ? AppSpacing.xs : AppSpacing.sm),
      ),
      isDense: size == ComponentSize.sm,
    );
  }

  // Créer un thème de texte basé sur AppTypography
  static TextTheme _createTextTheme(Color textColor) {
    return TextTheme(
      displayLarge: AppTypography.displayLarge.copyWith(color: textColor),
      displayMedium: AppTypography.displayMedium.copyWith(color: textColor),
      displaySmall: AppTypography.displaySmall.copyWith(color: textColor),
      headlineLarge: AppTypography.headlineLarge.copyWith(color: textColor),
      headlineMedium: AppTypography.headlineMedium.copyWith(color: textColor),
      headlineSmall: AppTypography.headlineSmall.copyWith(color: textColor),
      titleLarge: AppTypography.titleLarge.copyWith(color: textColor),
      titleMedium: AppTypography.titleMedium.copyWith(color: textColor),
      titleSmall: AppTypography.titleSmall.copyWith(color: textColor),
      bodyLarge: AppTypography.bodyLarge.copyWith(color: textColor),
      bodyMedium: AppTypography.bodyMedium.copyWith(color: textColor),
      bodySmall: AppTypography.bodySmall.copyWith(color: textColor),
      labelLarge: AppTypography.labelLarge.copyWith(color: textColor),
      labelMedium: AppTypography.labelMedium.copyWith(color: textColor),
      labelSmall: AppTypography.labelSmall.copyWith(color: textColor),
    );
  }

  // Configuration du thème clair
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.indigo,
    dividerColor: AppColors.grey.s100,
    colorScheme: ColorScheme.light(
      primary: AppColors.indigo,
      secondary: AppColors.indigo.s400,
      surface: Colors.white,
      error: AppColors.red.s500,
    ),
    textTheme: _createTextTheme(AppColors.grey.s800),
    cardTheme: CardTheme(
      elevation: AppSpacing.sm,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.sm),
        side: BorderSide(color: AppColors.gray.s50, width: 1),
      ),
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      shadowColor: AppColors.slate.withValues(alpha: .3),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: _createElevatedButtonStyle(
        backgroundColor: AppColors.indigo,
        foregroundColor: Colors.white,
        side: BorderSide(color: AppColors.indigo.s600, width: 1),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: _createOutlinedButtonStyle(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(AppSizes.getPadding(ComponentSize.md)),
        textStyle: WidgetStateProperty.all(AppTypography.labelLarge),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppColors.gray.s900;
          }
          return AppColors.gray;
        }),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        side: WidgetStateProperty.all(BorderSide.none),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.indigo.s400,
      selectionColor: AppColors.indigo.s400,
      selectionHandleColor: AppColors.indigo.s400,
    ),
    inputDecorationTheme: _createInputDecorationTheme(
      fillColor: Colors.white,
      hintColor: AppColors.gray.s300,
      enabledBorderColor: AppColors.gray.s300,
      focusedBorderColor: AppColors.indigo.s400,
      errorBorderColor: AppColors.red.s300,
    ),
    iconTheme: IconThemeData(
      color: AppColors.grey.s800, // Couleur d'icône par défaut en mode clair
    ),
  );

  // Configuration du thème sombre
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.grey.s900,
    primaryColor: AppColors.indigo.s400,
    dividerColor: AppColors.grey.s300,
    colorScheme: ColorScheme.dark(
      primary: AppColors.indigo.s200,
      secondary: AppColors.indigo.s300,
      surface: AppColors.grey.s800,
      error: AppColors.red.s300,
    ),
    textTheme: _createTextTheme(AppColors.grey.s50),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: _createElevatedButtonStyle(
        backgroundColor: AppColors.indigo.s400,
        foregroundColor: Colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: _createOutlinedButtonStyle(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.grey.s800,
        side: BorderSide.none,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(AppSizes.getPadding(ComponentSize.md)),
        textStyle: WidgetStateProperty.all(AppTypography.labelLarge),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppColors.gray.s50;
          }
          return AppColors.gray.s200;
        }),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        splashFactory: NoSplash.splashFactory,
        side: WidgetStateProperty.all(BorderSide.none),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.indigo.s400, // Couleur du curseur
      selectionColor: AppColors.indigo.s400, // Sélection de texte
      selectionHandleColor: AppColors.indigo.s400, // Poignée de sélection
    ),
    inputDecorationTheme: _createInputDecorationTheme(
      fillColor: AppColors.grey.s800,
      hintColor: AppColors.gray.s200,
      enabledBorderColor: AppColors.gray.s600,
      focusedBorderColor: AppColors.indigo.s400,
      errorBorderColor: AppColors.red.s300,
    ),
    iconTheme: IconThemeData(
      color: AppColors.grey.s50, // Couleur d'icône par défaut en mode sombre
    ),
  );
}
