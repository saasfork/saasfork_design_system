import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/foundations/responsive/breakpoints.dart';

void main() {
  group('SFBreakpoints', () {
    group('getScreenSize', () {
      test('renvoie mobile pour une largeur inférieure à 600', () {
        expect(SFBreakpoints.getScreenSize(599), equals(SFScreenSize.mobile));
        expect(SFBreakpoints.getScreenSize(0), equals(SFScreenSize.mobile));
      });

      test('renvoie tablet pour une largeur entre 600 et 899', () {
        expect(SFBreakpoints.getScreenSize(600), equals(SFScreenSize.tablet));
        expect(SFBreakpoints.getScreenSize(899), equals(SFScreenSize.tablet));
      });

      test('renvoie desktop pour une largeur entre 900 et 1199', () {
        expect(SFBreakpoints.getScreenSize(900), equals(SFScreenSize.desktop));
        expect(SFBreakpoints.getScreenSize(1199), equals(SFScreenSize.desktop));
      });

      test('renvoie largeDesktop pour une largeur de 1200 ou plus', () {
        expect(
          SFBreakpoints.getScreenSize(1200),
          equals(SFScreenSize.largeDesktop),
        );
        expect(
          SFBreakpoints.getScreenSize(1500),
          equals(SFScreenSize.largeDesktop),
        );
      });
    });

    group('getOrientation', () {
      testWidgets(
        'renvoie portrait quand la hauteur est supérieure à la largeur',
        (WidgetTester tester) async {
          final Size portraitSize = Size(400, 800);

          await tester.pumpWidget(
            MediaQuery(
              data: MediaQueryData(size: portraitSize),
              child: Builder(
                builder: (BuildContext context) {
                  final orientation = SFBreakpoints.getOrientation(context);
                  expect(orientation, equals(SFScreenOrientation.portrait));
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
          final Size landscapeSize = Size(800, 400);

          await tester.pumpWidget(
            MediaQuery(
              data: MediaQueryData(size: landscapeSize),
              child: Builder(
                builder: (BuildContext context) {
                  final orientation = SFBreakpoints.getOrientation(context);
                  expect(orientation, equals(SFScreenOrientation.landscape));
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
          SFBreakpoints.getColumnsForScreenSize(SFScreenSize.mobile),
          equals(SFBreakpoints.mobileColumns),
        );
        expect(
          SFBreakpoints.getColumnsForScreenSize(SFScreenSize.tablet),
          equals(SFBreakpoints.tabletColumns),
        );
        expect(
          SFBreakpoints.getColumnsForScreenSize(SFScreenSize.desktop),
          equals(SFBreakpoints.desktopColumns),
        );
        expect(
          SFBreakpoints.getColumnsForScreenSize(SFScreenSize.largeDesktop),
          equals(SFBreakpoints.largeDesktopColumns),
        );
      });
    });

    group('getHorizontalMargin', () {
      test('renvoie la marge correcte pour chaque taille d\'écran', () {
        expect(
          SFBreakpoints.getHorizontalMargin(SFScreenSize.mobile),
          equals(SFBreakpoints.horizontalMargins[SFScreenSize.mobile]),
        );
        expect(
          SFBreakpoints.getHorizontalMargin(SFScreenSize.tablet),
          equals(SFBreakpoints.horizontalMargins[SFScreenSize.tablet]),
        );
        expect(
          SFBreakpoints.getHorizontalMargin(SFScreenSize.desktop),
          equals(SFBreakpoints.horizontalMargins[SFScreenSize.desktop]),
        );
        expect(
          SFBreakpoints.getHorizontalMargin(SFScreenSize.largeDesktop),
          equals(SFBreakpoints.horizontalMargins[SFScreenSize.largeDesktop]),
        );
      });
    });
  });
}
