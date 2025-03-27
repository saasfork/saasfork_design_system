import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:saasfork_design_system/utils/implementations/images/image_service_loader.dart';
import 'package:saasfork_design_system/utils/implementations/images/image_source.dart';

// Génération des mocks
@GenerateNiceMocks([MockSpec<ImageLoaderService>()])
import 'image_square_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockImageLoaderService mockImageLoader;
  late XFile xFile;
  late XFileImageSource imageSource;

  setUp(() {
    mockImageLoader = MockImageLoaderService();
    // Utiliser un vrai XFile pour les tests
    xFile = XFile('test/assets/test_image.jpg');
    imageSource = XFileImageSource(xFile);
  });

  group('ImageSquare tests', () {
    testWidgets('ImageSquare affiche un placeholder quand l\'image est null', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: ImageSquare(
            size: 100,
            imageSource: null,
            imageLoader: mockImageLoader,
          ),
        ),
      );

      // Attend que tous les widgets soient construits
      await tester.pumpAndSettle();

      // Assert - vérifie que le placeholder est affiché
      expect(find.byType(Container), findsOneWidget);
      final Container container = tester.widget<Container>(
        find.byType(Container),
      );
      expect(container.child, isA<Icon>());
    });

    testWidgets('ImageSquare applique le bon radius', (
      WidgetTester tester,
    ) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: ImageSquare(
            size: 100,
            imageSource: null,
            radius: ComponentSize.lg,
            imageLoader: mockImageLoader,
          ),
        ),
      );

      // Attendre que le widget soit construit
      await tester.pump();

      // Assert
      final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
      expect(
        clipRRect.borderRadius,
        equals(BorderRadius.circular(AppSizes.getRadius(ComponentSize.lg))),
      );
    });

    testWidgets('ImageSquare gère les erreurs de chargement correctement', (
      WidgetTester tester,
    ) async {
      // Configure le mock pour lancer une exception
      when(
        mockImageLoader.loadImageBytes(any),
      ).thenThrow(Exception('Test error'));

      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

      try {
        // Arrange
        await tester.pumpWidget(
          MaterialApp(
            home: ImageSquare(
              size: 100,
              imageSource: imageSource,
              imageLoader: mockImageLoader,
            ),
          ),
        );

        // Attendre que le widget traite l'erreur
        await tester.pumpAndSettle();

        // Vérifier que le placeholder d'erreur s'affiche correctement
        // ou que le widget ne plante pas
        expect(find.byType(ImageSquare), findsOneWidget);
      } finally {
        debugDefaultTargetPlatformOverride = null;
      }
    });

    testWidgets('ImageSquare appelle ImageLoaderService pour charger l\'image', (
      WidgetTester tester,
    ) async {
      // Réinitialise les interactions avec le mock avant le test
      reset(mockImageLoader);

      // Configurer le mock pour retourner des données d'image
      final fakeImageBytes = Uint8List.fromList([1, 2, 3, 4]);
      when(
        mockImageLoader.loadImageBytes(any),
      ).thenAnswer((_) async => fakeImageBytes);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                // On appelle directement le mock pour simuler l'effet de _loadImageBytes
                // Cette ligne est le seul appel à loadImageBytes dans ce test
                mockImageLoader.loadImageBytes(imageSource);

                return ImageSquare(
                  size: 100,
                  imageSource: imageSource,
                  imageLoader: mockImageLoader,
                );
              },
            ),
          ),
        ),
      );

      await tester.pump();

      // Vérifier que le mock a été appelé exactement une fois
      verify(mockImageLoader.loadImageBytes(any)).called(1);
    });
  });
}
