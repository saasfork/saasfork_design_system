import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

void main() {
  testWidgets('AnimatedSwitchButton initializes with default values', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: AnimatedSwitchButton(onToggle: (value) {})),
      ),
    );

    expect(find.byType(AnimatedSwitchButton), findsOneWidget);

    final firstIconWidget = tester.widget<Opacity>(
      find.ancestor(
        of: find.byIcon(Icons.light_mode_rounded),
        matching: find.byType(Opacity),
      ),
    );
    expect(firstIconWidget.opacity, 1.0);

    final secondIconWidget = tester.widget<Opacity>(
      find.ancestor(
        of: find.byIcon(Icons.dark_mode_rounded),
        matching: find.byType(Opacity),
      ),
    );
    expect(secondIconWidget.opacity, 0.0);
  });

  testWidgets('AnimatedSwitchButton toggles state on tap', (
    WidgetTester tester,
  ) async {
    bool toggleValue = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimatedSwitchButton(
            onToggle: (value) {
              toggleValue = value;
            },
          ),
        ),
      ),
    );

    expect(toggleValue, isFalse);

    await tester.tap(find.byType(AnimatedSwitchButton));
    await tester.pumpAndSettle();

    expect(toggleValue, isTrue);

    await tester.tap(find.byType(AnimatedSwitchButton));
    await tester.pumpAndSettle();

    expect(toggleValue, isFalse);
  });

  testWidgets('AnimatedSwitchButton initializes with provided initialValue', (
    WidgetTester tester,
  ) async {
    bool toggleValue = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimatedSwitchButton(
            initialValue: true,
            onToggle: (value) {
              toggleValue = value;
            },
          ),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 200));

    await tester.tap(find.byType(AnimatedSwitchButton));
    await tester.pumpAndSettle();

    expect(toggleValue, isFalse);
  });

  testWidgets('AnimatedSwitchButton uses custom icons', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimatedSwitchButton(
            onToggle: (value) {},
            firstStateIcon: const Icon(Icons.add),
            secondStateIcon: const Icon(Icons.remove),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byIcon(Icons.light_mode_rounded), findsNothing);
  });

  testWidgets('AnimatedSwitchButton uses custom colors', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimatedSwitchButton(
            onToggle: (value) {},
            firstStateColor: Colors.red,
            secondStateColor: Colors.blue,
          ),
        ),
      ),
    );

    final container = tester.widget<Container>(
      find
          .descendant(
            of: find.byType(AnimatedSwitchButton),
            matching: find.byType(Container),
          )
          .first,
    );

    final BoxDecoration decoration = container.decoration as BoxDecoration;
    expect(decoration.color, Colors.red);
  });

  testWidgets('AnimatedSwitchButton updates when initialValue changes', (
    WidgetTester tester,
  ) async {
    bool initialValue = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: [
                  AnimatedSwitchButton(
                    initialValue: initialValue,
                    onToggle: (value) {},
                  ),
                  ElevatedButton(
                    onPressed:
                        () => setState(() => initialValue = !initialValue),
                    child: const Text('Toggle External'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );

    expect(initialValue, isFalse);

    await tester.tap(find.text('Toggle External'));
    await tester.pumpAndSettle();

    expect(initialValue, isTrue);
  });

  testWidgets('AnimatedSwitchButton respects size parameter', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimatedSwitchButton(
            onToggle: (value) {},
            size: ComponentSize.lg,
          ),
        ),
      ),
    );

    final iconFinder = find.byType(Icon).first;
    final Icon icon = tester.widget(iconFinder);

    expect(icon.size, AppSizes.getIconSize(ComponentSize.lg));
  });
}
