import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/foundations/responsive/breakpoints.dart';

void main() {
  group('SFBreakpoints', () {
    group('getScreenSize', () {
      testWidgets(
        'renvoie la bonne taille d\'écran en fonction de la largeur',
        (WidgetTester tester) async {
          final screenSizeTests = [
            {'size': const Size(320, 600), 'expectedSize': SFScreenSize.mobile},
            {'size': const Size(599, 800), 'expectedSize': SFScreenSize.mobile},
            {'size': const Size(600, 800), 'expectedSize': SFScreenSize.tablet},
            {
              'size': const Size(768, 1024),
              'expectedSize': SFScreenSize.tablet,
            },
            {'size': const Size(899, 800), 'expectedSize': SFScreenSize.tablet},
            {
              'size': const Size(900, 800),
              'expectedSize': SFScreenSize.desktop,
            },
            {
              'size': const Size(1024, 800),
              'expectedSize': SFScreenSize.desktop,
            },
            {
              'size': const Size(1199, 800),
              'expectedSize': SFScreenSize.desktop,
            },
            {
              'size': const Size(1200, 800),
              'expectedSize': SFScreenSize.largeDesktop,
            },
            {
              'size': const Size(1440, 900),
              'expectedSize': SFScreenSize.largeDesktop,
            },
          ];

          for (final test in screenSizeTests) {
            await tester.pumpWidget(
              MediaQuery(
                data: MediaQueryData(size: test['size'] as Size),
                child: Builder(
                  builder: (context) {
                    expect(
                      SFBreakpoints.getScreenSize(context),
                      equals(test['expectedSize']),
                      reason: 'Pour une taille d\'écran ${test['size']}',
                    );
                    return const SizedBox.shrink();
                  },
                ),
              ),
            );
          }
        },
      );
    });

    group('getOrientation', () {
      testWidgets(
        'renvoie l\'orientation correcte en fonction des dimensions de l\'écran',
        (WidgetTester tester) async {
          final orientationTests = [
            {
              'size': const Size(400, 800),
              'expectedOrientation': SFScreenOrientation.portrait,
              'description': 'portrait (hauteur > largeur)',
            },
            {
              'size': const Size(800, 400),
              'expectedOrientation': SFScreenOrientation.landscape,
              'description': 'landscape (largeur > hauteur)',
            },
            {
              'size': const Size(500, 500),
              'expectedOrientation': SFScreenOrientation.portrait,
              'description': 'carré (dimensions égales)',
            },
          ];

          for (final test in orientationTests) {
            await tester.pumpWidget(
              MediaQuery(
                data: MediaQueryData(size: test['size'] as Size),
                child: Builder(
                  builder: (BuildContext context) {
                    final orientation = SFBreakpoints.getOrientation(context);
                    expect(
                      orientation,
                      equals(test['expectedOrientation']),
                      reason:
                          'Pour ${test['description']} avec taille ${test['size']}',
                    );
                    return const SizedBox.shrink();
                  },
                ),
              ),
            );
          }
        },
      );
    });

    group('getColumnsForScreenSize', () {
      test('renvoie le bon nombre de colonnes pour chaque taille d\'écran', () {
        final columnsTests = [
          {
            'screenSize': SFScreenSize.mobile,
            'expectedColumns': SFBreakpoints.mobileColumns,
          },
          {
            'screenSize': SFScreenSize.tablet,
            'expectedColumns': SFBreakpoints.tabletColumns,
          },
          {
            'screenSize': SFScreenSize.desktop,
            'expectedColumns': SFBreakpoints.desktopColumns,
          },
          {
            'screenSize': SFScreenSize.largeDesktop,
            'expectedColumns': SFBreakpoints.largeDesktopColumns,
          },
        ];

        for (final test in columnsTests) {
          expect(
            SFBreakpoints.getColumnsForScreenSize(
              test['screenSize'] as SFScreenSize,
            ),
            equals(test['expectedColumns']),
            reason: 'Pour la taille d\'écran ${test['screenSize']}',
          );
        }
      });
    });

    group('getHorizontalMargin', () {
      test('renvoie la marge correcte pour chaque taille d\'écran', () {
        final marginTests = [
          {
            'screenSize': SFScreenSize.mobile,
            'expectedMargin':
                SFBreakpoints.horizontalMargins[SFScreenSize.mobile],
          },
          {
            'screenSize': SFScreenSize.tablet,
            'expectedMargin':
                SFBreakpoints.horizontalMargins[SFScreenSize.tablet],
          },
          {
            'screenSize': SFScreenSize.desktop,
            'expectedMargin':
                SFBreakpoints.horizontalMargins[SFScreenSize.desktop],
          },
          {
            'screenSize': SFScreenSize.largeDesktop,
            'expectedMargin':
                SFBreakpoints.horizontalMargins[SFScreenSize.largeDesktop],
          },
        ];

        for (final test in marginTests) {
          expect(
            SFBreakpoints.getHorizontalMargin(
              test['screenSize'] as SFScreenSize,
            ),
            equals(test['expectedMargin']),
            reason: 'Pour la taille d\'écran ${test['screenSize']}',
          );
        }
      });
    });

    testWidgets('Vérifie les points de rupture avec MediaQuery', (
      tester,
    ) async {
      final screenSizeTests = [
        {
          'size': const Size(320, 600),
          'expectedScreenSize': SFScreenSize.mobile,
        },
        {
          'size': const Size(768, 1024),
          'expectedScreenSize': SFScreenSize.tablet,
        },
        {
          'size': const Size(1100, 800),
          'expectedScreenSize': SFScreenSize.desktop,
        },
        {
          'size': const Size(1440, 900),
          'expectedScreenSize': SFScreenSize.largeDesktop,
        },
      ];

      for (final test in screenSizeTests) {
        await tester.pumpWidget(
          MediaQuery(
            data: MediaQueryData(size: test['size'] as Size),
            child: Builder(
              builder: (context) {
                expect(
                  SFBreakpoints.getScreenSize(context),
                  test['expectedScreenSize'],
                  reason: 'Pour la taille ${test['size']}',
                );
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      }
    });
  });
}
