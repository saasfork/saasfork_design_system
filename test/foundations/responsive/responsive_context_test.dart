import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/foundations/responsive/breakpoints.dart';
import 'package:saasfork_design_system/foundations/responsive/responsive_context.dart';

void main() {
  group('ResponsiveContext', () {
    testWidgets('Vérifie les points de rupture utilisés dans les tests', (
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
                );
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      }
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
              expect(context.screenSize, SFScreenSize.mobile);
              expect(context.isMobile, isTrue);
              expect(context.isTablet, isFalse);
              expect(context.isDesktop, isFalse);
              expect(context.isLargeDesktop, isFalse);
              expect(context.isMobileOrTablet, isTrue);
              expect(context.isDesktopOrLarger, isFalse);
              expect(
                context.columns,
                equals(
                  SFBreakpoints.getColumnsForScreenSize(SFScreenSize.mobile),
                ),
              );
              expect(
                context.horizontalMargin,
                equals(SFBreakpoints.getHorizontalMargin(SFScreenSize.mobile)),
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
              expect(context.screenSize, SFScreenSize.tablet);
              expect(context.isMobile, isFalse);
              expect(context.isTablet, isTrue);
              expect(context.isMobileOrTablet, isTrue);
              expect(
                context.columns,
                equals(
                  SFBreakpoints.getColumnsForScreenSize(SFScreenSize.tablet),
                ),
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
      // Ajustement à 1100 au lieu de 1200 pour être sûr d'obtenir SFScreenSize.desktop
      final Size desktopSize = const Size(1100, 800);

      await tester.pumpWidget(
        MediaQuery(
          data: MediaQueryData(size: desktopSize),
          child: Builder(
            builder: (context) {
              expect(context.screenWidth, 1100);
              expect(context.screenSize, SFScreenSize.desktop);
              expect(context.isDesktop, isTrue);
              expect(context.isDesktopOrLarger, isTrue);
              expect(
                context.columns,
                equals(
                  SFBreakpoints.getColumnsForScreenSize(SFScreenSize.desktop),
                ),
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
              expect(context.screenSize, SFScreenSize.largeDesktop);
              expect(context.isLargeDesktop, isTrue);
              expect(context.isDesktopOrLarger, isTrue);
              expect(
                context.columns,
                equals(
                  SFBreakpoints.getColumnsForScreenSize(
                    SFScreenSize.largeDesktop,
                  ),
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
              expect(context.orientation, SFScreenOrientation.portrait);
              expect(context.isPortrait, isTrue);
              expect(context.isLandscape, isFalse);
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
              expect(context.orientation, SFScreenOrientation.landscape);
              expect(context.isPortrait, isFalse);
              expect(context.isLandscape, isTrue);
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
