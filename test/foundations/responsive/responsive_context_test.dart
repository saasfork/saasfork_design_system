import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/foundations/responsive/breakpoints.dart';
import 'package:saasfork_design_system/foundations/responsive/responsive_context.dart';

void main() {
  group('ResponsiveContext', () {
    // Test pour les breakpoints de référence
    test('Vérifie les points de rupture utilisés dans les tests', () {
      expect(Breakpoints.getScreenSize(320), ScreenSize.mobile);
      expect(Breakpoints.getScreenSize(768), ScreenSize.tablet);
      expect(Breakpoints.getScreenSize(1100), ScreenSize.desktop);
      expect(Breakpoints.getScreenSize(1440), ScreenSize.largeDesktop);
    });

    testWidgets('détecte correctement le type d\'écran mobile', (tester) async {
      final Size mobileSize = const Size(320, 600);

      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(size: mobileSize),
          child: Builder(
            builder: (context) {
              expect(context.screenWidth, 320);
              expect(context.screenHeight, 600);
              expect(context.screenSize, ScreenSize.mobile);
              expect(context.isMobile, true);
              expect(context.isTablet, false);
              expect(context.isDesktop, false);
              expect(context.isLargeDesktop, false);
              expect(context.isMobileOrTablet, true);
              expect(context.isDesktopOrLarger, false);
              expect(
                context.columns,
                equals(Breakpoints.getColumnsForScreenSize(ScreenSize.mobile)),
              );
              expect(
                context.horizontalMargin,
                equals(Breakpoints.getHorizontalMargin(ScreenSize.mobile)),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('détecte correctement le type d\'écran tablette', (
      tester,
    ) async {
      final Size tabletSize = const Size(768, 1024);

      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(size: tabletSize),
          child: Builder(
            builder: (context) {
              expect(context.screenWidth, 768);
              expect(context.screenSize, ScreenSize.tablet);
              expect(context.isMobile, false);
              expect(context.isTablet, true);
              expect(context.isMobileOrTablet, true);
              expect(
                context.columns,
                equals(Breakpoints.getColumnsForScreenSize(ScreenSize.tablet)),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('détecte correctement le type d\'écran desktop', (
      tester,
    ) async {
      // Ajustement à 1100 au lieu de 1200 pour être sûr d'obtenir ScreenSize.desktop
      final Size desktopSize = const Size(1100, 800);

      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(size: desktopSize),
          child: Builder(
            builder: (context) {
              expect(context.screenWidth, 1100);
              expect(context.screenSize, ScreenSize.desktop);
              expect(context.isDesktop, true);
              expect(context.isDesktopOrLarger, true);
              expect(
                context.columns,
                equals(Breakpoints.getColumnsForScreenSize(ScreenSize.desktop)),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('détecte correctement le type d\'écran large desktop', (
      tester,
    ) async {
      final Size largeDesktopSize = const Size(1440, 900);

      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(size: largeDesktopSize),
          child: Builder(
            builder: (context) {
              expect(context.screenWidth, 1440);
              expect(context.screenSize, ScreenSize.largeDesktop);
              expect(context.isLargeDesktop, true);
              expect(context.isDesktopOrLarger, true);
              expect(
                context.columns,
                equals(
                  Breakpoints.getColumnsForScreenSize(ScreenSize.largeDesktop),
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('détecte correctement l\'orientation portrait', (tester) async {
      final Size portraitSize = const Size(400, 800);

      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(size: portraitSize),
          child: Builder(
            builder: (context) {
              expect(context.orientation, ScreenOrientation.portrait);
              expect(context.isPortrait, true);
              expect(context.isLandscape, false);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets('détecte correctement l\'orientation paysage', (tester) async {
      final Size landscapeSize = const Size(800, 400);

      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(size: landscapeSize),
          child: Builder(
            builder: (context) {
              expect(context.orientation, ScreenOrientation.landscape);
              expect(context.isPortrait, false);
              expect(context.isLandscape, true);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });

    testWidgets(
      'méthode responsive retourne les valeurs correctes selon la taille d\'écran',
      (tester) async {
        // Test pour mobile
        await tester.pumpWidget(
          MediaQuery(
            data: MediaQueryData(size: const Size(320, 600)),
            child: Builder(
              builder: (context) {
                expect(
                  context.responsive(
                    mobile: 'mobile',
                    tablet: 'tablet',
                    desktop: 'desktop',
                    largeDesktop: 'largeDesktop',
                  ),
                  'mobile',
                );
                return const SizedBox.shrink();
              },
            ),
          ),
        );

        // Test pour tablet
        await tester.pumpWidget(
          MediaQuery(
            data: MediaQueryData(size: const Size(768, 1024)),
            child: Builder(
              builder: (context) {
                expect(
                  context.responsive(
                    mobile: 'mobile',
                    tablet: 'tablet',
                    desktop: 'desktop',
                    largeDesktop: 'largeDesktop',
                  ),
                  'tablet',
                );
                return const SizedBox.shrink();
              },
            ),
          ),
        );

        // Test pour desktop
        await tester.pumpWidget(
          MediaQuery(
            data: MediaQueryData(size: const Size(1100, 800)),
            child: Builder(
              builder: (context) {
                expect(
                  context.responsive(
                    mobile: 'mobile',
                    tablet: 'tablet',
                    desktop: 'desktop',
                    largeDesktop: 'largeDesktop',
                  ),
                  'desktop',
                );
                return const SizedBox.shrink();
              },
            ),
          ),
        );

        // Test pour valeurs par défaut (fallback)
        await tester.pumpWidget(
          MediaQuery(
            data: MediaQueryData(size: const Size(768, 1024)),
            child: Builder(
              builder: (context) {
                expect(
                  context.responsive(mobile: 'mobile'),
                  'mobile', // Fallback to mobile value
                );
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      },
    );

    testWidgets('paddings responsives sont correctement calculés', (
      tester,
    ) async {
      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(size: const Size(320, 600)),
          child: Builder(
            builder: (context) {
              expect(
                context.responsiveHorizontalPadding,
                EdgeInsets.symmetric(horizontal: context.horizontalMargin),
              );

              expect(
                context.responsivePadding,
                EdgeInsets.symmetric(
                  horizontal: context.horizontalMargin,
                  vertical: context.gap,
                ),
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });
}
