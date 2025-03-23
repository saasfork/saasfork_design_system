import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/foundations/responsive/breakpoints.dart';

void main() {
  group('Breakpoints', () {
    group('getScreenSize', () {
      test('renvoie mobile pour une largeur inférieure à 600', () {
        expect(Breakpoints.getScreenSize(599), equals(ScreenSize.mobile));
        expect(Breakpoints.getScreenSize(0), equals(ScreenSize.mobile));
      });

      test('renvoie tablet pour une largeur entre 600 et 899', () {
        expect(Breakpoints.getScreenSize(600), equals(ScreenSize.tablet));
        expect(Breakpoints.getScreenSize(899), equals(ScreenSize.tablet));
      });

      test('renvoie desktop pour une largeur entre 900 et 1199', () {
        expect(Breakpoints.getScreenSize(900), equals(ScreenSize.desktop));
        expect(Breakpoints.getScreenSize(1199), equals(ScreenSize.desktop));
      });

      test('renvoie largeDesktop pour une largeur de 1200 ou plus', () {
        expect(
          Breakpoints.getScreenSize(1200),
          equals(ScreenSize.largeDesktop),
        );
        expect(
          Breakpoints.getScreenSize(1500),
          equals(ScreenSize.largeDesktop),
        );
      });
    });

    group('getOrientation', () {
      testWidgets(
        'renvoie portrait quand la hauteur est supérieure à la largeur',
        (WidgetTester tester) async {
          // Définir une taille en portrait (hauteur > largeur)
          final Size portraitSize = Size(400, 800);

          await tester.pumpWidget(
            MediaQuery(
              data: MediaQueryData(size: portraitSize),
              child: Builder(
                builder: (BuildContext context) {
                  // Vérifier l'orientation immédiatement plutôt qu'avec addTearDown
                  final orientation = Breakpoints.getOrientation(context);
                  expect(orientation, equals(ScreenOrientation.portrait));
                  return Container();
                },
              ),
            ),
          );
        },
      );

      testWidgets(
        'renvoie landscape quand la largeur est supérieure à la hauteur',
        (WidgetTester tester) async {
          // Définir une taille en paysage (largeur > hauteur)
          final Size landscapeSize = Size(800, 400);

          await tester.pumpWidget(
            MediaQuery(
              data: MediaQueryData(size: landscapeSize),
              child: Builder(
                builder: (BuildContext context) {
                  // Vérifier l'orientation immédiatement plutôt qu'avec addTearDown
                  final orientation = Breakpoints.getOrientation(context);
                  expect(orientation, equals(ScreenOrientation.landscape));
                  return Container();
                },
              ),
            ),
          );
        },
      );
    });

    group('getColumnsForScreenSize', () {
      test('renvoie le bon nombre de colonnes pour chaque taille d\'écran', () {
        expect(
          Breakpoints.getColumnsForScreenSize(ScreenSize.mobile),
          equals(Breakpoints.mobileColumns),
        );
        expect(
          Breakpoints.getColumnsForScreenSize(ScreenSize.tablet),
          equals(Breakpoints.tabletColumns),
        );
        expect(
          Breakpoints.getColumnsForScreenSize(ScreenSize.desktop),
          equals(Breakpoints.desktopColumns),
        );
        expect(
          Breakpoints.getColumnsForScreenSize(ScreenSize.largeDesktop),
          equals(Breakpoints.largeDesktopColumns),
        );
      });
    });

    group('getHorizontalMargin', () {
      test('renvoie la marge correcte pour chaque taille d\'écran', () {
        expect(
          Breakpoints.getHorizontalMargin(ScreenSize.mobile),
          equals(Breakpoints.horizontalMargins[ScreenSize.mobile]),
        );
        expect(
          Breakpoints.getHorizontalMargin(ScreenSize.tablet),
          equals(Breakpoints.horizontalMargins[ScreenSize.tablet]),
        );
        expect(
          Breakpoints.getHorizontalMargin(ScreenSize.desktop),
          equals(Breakpoints.horizontalMargins[ScreenSize.desktop]),
        );
        expect(
          Breakpoints.getHorizontalMargin(ScreenSize.largeDesktop),
          equals(Breakpoints.horizontalMargins[ScreenSize.largeDesktop]),
        );
      });
    });
  });
}
