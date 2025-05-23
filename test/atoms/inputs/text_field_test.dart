import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

void main() {
  group('SFTextField', () {
    testWidgets('renders correctly with default props', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(inputDecorationTheme: const InputDecorationTheme()),
          home: const Scaffold(body: SFTextField(placeholder: 'Enter text')),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Enter text'), findsOneWidget);

      final TextField textField = tester.widget(find.byType(TextField));
      expect(textField.controller, isNull);
      expect(textField.decoration!.hintText, equals('Enter text'));
      expect(textField.decoration!.filled, isTrue);
      expect(textField.enabled, isTrue);
    });

    testWidgets('renders in error state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.red.s300),
              ),
            ),
          ),
          home: const Scaffold(
            body: SFTextField(placeholder: 'Enter text', isInError: true),
          ),
        ),
      );

      final TextField textField = tester.widget(find.byType(TextField));
      expect(textField.decoration!.enabledBorder, isA<OutlineInputBorder>());

      final OutlineInputBorder border =
          textField.decoration!.enabledBorder as OutlineInputBorder;
      expect(border.borderSide.color, equals(AppColors.red.s300));
    });

    testWidgets('renders with different sizes', (WidgetTester tester) async {
      for (final size in ComponentSize.values) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: SFTextField(placeholder: 'Test', size: size)),
          ),
        );

        final TextField textField = tester.widget(find.byType(TextField));
        expect(
          textField.decoration!.contentPadding,
          equals(AppSizes.getInputPadding(size)),
        );
        expect(
          textField.decoration!.constraints,
          equals(AppSizes.getInputConstraints(size)),
        );

        await tester.pumpAndSettle();
      }
    });

    testWidgets('renders with custom background color', (
      WidgetTester tester,
    ) async {
      const Color customColor = Colors.amber;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SFTextField(
              placeholder: 'Test',
              backgroundColor: customColor,
              disabled:
                  false, // Désactiver le mode disabled pour voir la couleur personnalisée
            ),
          ),
        ),
      );

      final TextField textField = tester.widget(find.byType(TextField));
      expect(textField.decoration!.filled, isTrue);
      expect(textField.decoration!.fillColor, equals(customColor));
    });

    testWidgets('controller works correctly', (WidgetTester tester) async {
      final controller = TextEditingController(text: 'Initial text');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFTextField(placeholder: 'Test', controller: controller),
          ),
        ),
      );

      expect(find.text('Initial text'), findsOneWidget);

      controller.text = 'Updated text';
      await tester.pump();

      expect(find.text('Updated text'), findsOneWidget);
    });

    testWidgets('renders with prefix text correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.sm),
              ),
            ),
          ),
          home: const Scaffold(
            body: SFTextField(placeholder: 'Test', prefixText: 'Prefix'),
          ),
        ),
      );

      expect(find.text('Prefix'), findsOneWidget);

      // Trouver tous les Container qui contiennent le texte de préfixe
      final Finder containerFinder = find.ancestor(
        of: find.text('Prefix'),
        matching: find.byType(Container),
      );
      expect(containerFinder, findsWidgets);

      // Chercher parmi ces containers celui qui a une décoration
      bool foundDecoratedContainer = false;
      for (int i = 0; i < tester.widgetList(containerFinder).length; i++) {
        final Container container = tester.widget<Container>(
          containerFinder.at(i),
        );
        if (container.decoration != null) {
          foundDecoratedContainer = true;
          final BoxDecoration decoration =
              container.decoration as BoxDecoration;
          expect(decoration.color, equals(AppColors.gray.s50));
          break;
        }
      }
      expect(
        foundDecoratedContainer,
        isTrue,
        reason: 'Aucun container avec décoration trouvé',
      );
    });

    testWidgets('prefix has error styling when in error state', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.sm),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.red.s300),
                borderRadius: BorderRadius.circular(AppSpacing.sm),
              ),
            ),
          ),
          home: const Scaffold(
            body: SFTextField(
              placeholder: 'Test',
              prefixText: 'Prefix',
              isInError: true,
            ),
          ),
        ),
      );

      expect(find.text('Prefix'), findsOneWidget);

      // Trouver tous les Container qui contiennent le texte de préfixe
      final Finder containerFinder = find.ancestor(
        of: find.text('Prefix'),
        matching: find.byType(Container),
      );
      expect(containerFinder, findsWidgets);

      // Chercher parmi ces containers celui qui a une décoration
      bool foundDecoratedContainer = false;
      for (int i = 0; i < tester.widgetList(containerFinder).length; i++) {
        final Container container = tester.widget<Container>(
          containerFinder.at(i),
        );
        if (container.decoration != null) {
          foundDecoratedContainer = true;
          final BoxDecoration decoration =
              container.decoration as BoxDecoration;
          expect(decoration.color, equals(AppColors.red.withAlpha(10)));
          break;
        }
      }
      expect(
        foundDecoratedContainer,
        isTrue,
        reason: 'Aucun container avec décoration trouvé',
      );
    });

    testWidgets('prefix text has correct border radius', (
      WidgetTester tester,
    ) async {
      const double testBorderRadius = 12.0;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(testBorderRadius),
              ),
            ),
          ),
          home: const Scaffold(
            body: SFTextField(placeholder: 'Test', prefixText: 'Prefix'),
          ),
        ),
      );

      // Trouver tous les Container qui contiennent le texte de préfixe
      final Finder containerFinder = find.ancestor(
        of: find.text('Prefix'),
        matching: find.byType(Container),
      );

      // Chercher parmi ces containers celui qui a une décoration avec borderRadius
      bool foundDecoratedContainer = false;
      for (int i = 0; i < tester.widgetList(containerFinder).length; i++) {
        final Container container = tester.widget<Container>(
          containerFinder.at(i),
        );
        if (container.decoration != null) {
          foundDecoratedContainer = true;
          final BoxDecoration decoration =
              container.decoration as BoxDecoration;
          expect(decoration.borderRadius, isA<BorderRadius>());
          final BorderRadius borderRadius =
              decoration.borderRadius as BorderRadius;
          expect(borderRadius.topLeft.x, equals(testBorderRadius));
          expect(borderRadius.bottomLeft.x, equals(testBorderRadius));
          break;
        }
      }
      expect(
        foundDecoratedContainer,
        isTrue,
        reason: 'Aucun container avec décoration trouvé',
      );
    });

    testWidgets('should not display suffix icon when suffixWidget is null', (
      WidgetTester tester,
    ) async {
      // ARRANGE
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SFTextField(placeholder: 'Test Placeholder')),
        ),
      );

      // ASSERT
      expect(find.byType(TextField), findsOneWidget);

      // Verify no suffix icon is present
      final TextField textField = tester.widget<TextField>(
        find.byType(TextField),
      );
      expect(textField.decoration?.suffixIcon, isNull);
    });

    testWidgets('should display suffix icon when suffixWidget is provided', (
      WidgetTester tester,
    ) async {
      // ARRANGE
      const testIcon = Icon(Icons.search);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFTextField(
              placeholder: 'Test Placeholder',
              suffixWidget: testIcon,
            ),
          ),
        ),
      );

      // ASSERT
      expect(find.byType(TextField), findsOneWidget);

      // Verify suffix icon is present
      final TextField textField = tester.widget<TextField>(
        find.byType(TextField),
      );
      expect(textField.decoration?.suffixIcon, isNotNull);

      // Find the icon itself
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets(
      'should display CircularProgressIndicator when provided as suffixWidget',
      (WidgetTester tester) async {
        // ARRANGE
        final loadingIndicator = Container(
          width: 24,
          height: 24,
          padding: const EdgeInsets.all(4),
          child: const CircularProgressIndicator(),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SFTextField(
                placeholder: 'Test Placeholder',
                suffixWidget: loadingIndicator,
              ),
            ),
          ),
        );

        // ASSERT
        expect(find.byType(TextField), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        // Verify suffix icon is present
        final TextField textField = tester.widget<TextField>(
          find.byType(TextField),
        );
        expect(textField.decoration?.suffixIcon, isNotNull);
      },
    );
  });

  group('SFTextField - FocusNode tests', () {
    testWidgets('Should use provided focusNode', (WidgetTester tester) async {
      // Arrange
      final FocusNode focusNode = FocusNode();

      // Act
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(),
          home: Scaffold(
            body: SFTextField(
              placeholder: 'Test placeholder',
              focusNode: focusNode,
              disabled: false,
            ),
          ),
        ),
      );

      // Assert
      final TextField textField = tester.widget(find.byType(TextField));
      expect(textField.focusNode, focusNode);
    });

    testWidgets(
      'Should receive focus when focusNode.requestFocus() is called',
      (WidgetTester tester) async {
        // Arrange
        final FocusNode focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(),
            home: Scaffold(
              body: SFTextField(
                placeholder: 'Test placeholder',
                focusNode: focusNode,
                disabled: false,
              ),
            ),
          ),
        );

        // Act
        focusNode.requestFocus();
        await tester.pump();

        // Assert
        expect(focusNode.hasFocus, isTrue);
      },
    );

    testWidgets('Should lose focus when focusNode.unfocus() is called', (
      WidgetTester tester,
    ) async {
      // Arrange
      final FocusNode focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(),
          home: Scaffold(
            body: SFTextField(
              placeholder: 'Test placeholder',
              focusNode: focusNode,
              disabled: false,
            ),
          ),
        ),
      );

      // Focus first
      focusNode.requestFocus();
      await tester.pump();
      expect(focusNode.hasFocus, isTrue);

      // Act
      focusNode.unfocus();
      await tester.pump();

      // Assert
      expect(focusNode.hasFocus, isFalse);
    });

    tearDown(() {
      // Clean up focus nodes after each test
      FocusManager.instance.highlightStrategy =
          FocusHighlightStrategy.automatic;
      FocusManager.instance.rootScope.unfocus();
    });
  });

  group('SFTextField - Fonctionnalités supplémentaires', () {
    testWidgets('onSubmitted est appelé correctement', (
      WidgetTester tester,
    ) async {
      // Arrange
      bool wasSubmitted = false;
      String submittedValue = '';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFTextField(
              placeholder: 'Test',
              disabled: false, // Activer le champ pour permettre la soumission
              onSubmitted: (value) {
                wasSubmitted = true;
                submittedValue = value;
              },
            ),
          ),
        ),
      );

      // Act
      await tester.enterText(find.byType(TextField), 'Hello');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // Assert
      expect(wasSubmitted, isTrue);
      expect(submittedValue, equals('Hello'));
    });

    testWidgets('autofocus fonctionne correctement', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFTextField(
              placeholder: 'Test',
              autofocus: true,
              disabled: false, // Activer le champ pour permettre le focus
            ),
          ),
        ),
      );

      // Assert
      final TextField textField = tester.widget(find.byType(TextField));
      expect(textField.autofocus, isTrue);

      // Vérifier que le champ a bien le focus
      await tester.pump();
      expect(
        FocusScope.of(tester.element(find.byType(TextField))).hasFocus,
        isTrue,
      );
    });

    testWidgets('textInputAction est correctement appliqué', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFTextField(
              placeholder: 'Test',
              textInputAction: TextInputAction.search,
            ),
          ),
        ),
      );

      // Assert
      final TextField textField = tester.widget(find.byType(TextField));
      expect(textField.textInputAction, equals(TextInputAction.search));
    });

    testWidgets('builder fonctionne correctement', (WidgetTester tester) async {
      // Arrange
      Widget customBuilder(BuildContext context, Widget child) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.purple, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: child,
        );
      }

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFTextField(placeholder: 'Test', builder: customBuilder),
          ),
        ),
      );

      // Assert
      final customContainer =
          find
              .ancestor(
                of: find.byType(TextField),
                matching: find.byType(Container),
              )
              .first;

      final Container container = tester.widget(customContainer);
      final BoxDecoration decoration = container.decoration as BoxDecoration;
      expect(decoration.border, isA<Border>());

      final Border border = decoration.border as Border;
      expect(border.top.color, equals(Colors.purple));
      expect(border.top.width, equals(2));
    });

    testWidgets('semanticsLabel fonctionne correctement', (
      WidgetTester tester,
    ) async {
      // Arrange
      const String customLabel = 'Champ de recherche';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFTextField(placeholder: 'Test', semanticsLabel: customLabel),
          ),
        ),
      );

      // Assert
      // Trouver le Semantics qui est associé directement à SFTextField
      final semanticsWidget =
          find
              .descendant(
                of: find.byType(SFTextField),
                matching: find.byType(Semantics),
              )
              .first;

      final Semantics semantics = tester.widget(semanticsWidget);
      expect(semantics.properties.label, equals(customLabel));
      expect(semantics.properties.textField, isTrue);
    });

    testWidgets('utilise placeholder comme semanticsLabel quand non spécifié', (
      WidgetTester tester,
    ) async {
      // Arrange
      const String placeholder = 'Entrez votre texte ici';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: SFTextField(placeholder: placeholder)),
        ),
      );

      // Assert
      // Trouver le Semantics qui est associé directement à SFTextField
      final semanticsWidget =
          find
              .descendant(
                of: find.byType(SFTextField),
                matching: find.byType(Semantics),
              )
              .first;

      final Semantics semantics = tester.widget(semanticsWidget);
      expect(semantics.properties.label, equals(placeholder));
    });
  });

  group('SFTextField - État désactivé', () {
    testWidgets('affiche correctement lorsque disabled=true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(inputDecorationTheme: const InputDecorationTheme()),
          home: const Scaffold(
            body: SFTextField(placeholder: 'Champ désactivé', disabled: true),
          ),
        ),
      );

      final TextField textField = tester.widget(find.byType(TextField));

      // Vérifier que le TextField est bien désactivé
      expect(textField.enabled, isFalse);

      // Vérifier que le fond est rempli
      expect(textField.decoration?.filled, isTrue);
    });

    testWidgets('ne permet pas l\'édition lorsque désactivé', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFTextField(placeholder: 'Champ désactivé', disabled: true),
          ),
        ),
      );

      // Tentative d'entrer du texte
      await tester.enterText(find.byType(TextField), 'Test text');
      await tester.pump();

      // Vérifier qu'aucun texte n'a été entré (le champ est désactivé)
      expect(find.text('Test text'), findsNothing);
    });

    testWidgets('garde la même couleur de bordure que l\'état normal', (
      WidgetTester tester,
    ) async {
      final Color normalBorderColor = AppColors.gray.s300;

      // D'abord, créer un champ normal pour capturer sa couleur de bordure
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: normalBorderColor),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: normalBorderColor),
              ),
            ),
          ),
          home: const Scaffold(
            body: Column(
              children: [
                SFTextField(placeholder: 'Champ normal', disabled: false),
                SFTextField(placeholder: 'Champ désactivé', disabled: true),
              ],
            ),
          ),
        ),
      );

      // Obtenir les deux TextField pour comparer leurs bordures
      final TextField normalTextField = tester.widget(
        find.byType(TextField).first,
      );
      final TextField disabledTextField = tester.widget(
        find.byType(TextField).last,
      );

      // Vérifier que les bordures ont la même couleur
      final OutlineInputBorder normalBorder =
          normalTextField.decoration!.enabledBorder as OutlineInputBorder;
      final OutlineInputBorder disabledBorder =
          disabledTextField.decoration!.disabledBorder as OutlineInputBorder;

      expect(
        disabledBorder.borderSide.color,
        equals(normalBorder.borderSide.color),
      );
    });

    testWidgets(
      'est correctement désactivé quand disabled=true est passé au constructeur',
      (WidgetTester tester) async {
        // Créer un contrôleur pour vérifier qu'on ne peut pas modifier le texte
        final controller = TextEditingController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SFTextField(
                placeholder: 'Champ désactivé',
                disabled: true,
                controller: controller,
              ),
            ),
          ),
        );

        // Vérifier que le TextField est désactivé au niveau du widget
        final TextField textField = tester.widget(find.byType(TextField));
        expect(textField.enabled, isFalse);

        // Essayer de taper du texte programmatiquement (ne devrait pas fonctionner visuellement)
        controller.text = 'Texte test';
        await tester.pump();

        // Le texte est visible dans le contrôleur, mais le champ est visuellement désactivé
        expect(controller.text, equals('Texte test'));
        expect(textField.enabled, isFalse);
      },
    );

    testWidgets('affiche correctement lorsque disabled=false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(inputDecorationTheme: const InputDecorationTheme()),
          home: const Scaffold(
            body: SFTextField(placeholder: 'Champ activé', disabled: false),
          ),
        ),
      );

      final TextField textField = tester.widget(find.byType(TextField));

      // Vérifier que le TextField est bien activé
      expect(textField.enabled, isTrue);

      // Vérifier que le fond est rempli
      expect(textField.decoration?.filled, isTrue);
    });

    testWidgets('permet l\'édition lorsque disabled=false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SFTextField(placeholder: 'Champ activé', disabled: false),
          ),
        ),
      );

      // Tentative d'entrer du texte
      await tester.enterText(find.byType(TextField), 'Test text');
      await tester.pump();

      // Vérifier que le texte a bien été entré
      expect(find.text('Test text'), findsOneWidget);
    });
  });
}
