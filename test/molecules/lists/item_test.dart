import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

void main() {
  testWidgets('SFItem should render with required properties', (
    WidgetTester tester,
  ) async {
    // Arrange
    const label = 'Test Item';
    const icon = Icons.star;

    // Act
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: SFItem(label: label, icon: icon))),
    );

    // Assert
    expect(find.byType(SFItem), findsOneWidget);
    expect(find.byType(ListTile), findsOneWidget);
    expect(find.text(label), findsOneWidget);
    expect(find.byIcon(icon), findsOneWidget);
  });

  testWidgets('SFItem should use default size when not specified', (
    WidgetTester tester,
  ) async {
    // Arrange
    const label = 'Test Item';
    const icon = Icons.star;

    // Act
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: SFItem(label: label, icon: icon))),
    );

    // Assert
    final sfItem = tester.widget<SFItem>(find.byType(SFItem));
    expect(sfItem.size, ComponentSize.md);
  });

  testWidgets('SFItem should use custom size when specified', (
    WidgetTester tester,
  ) async {
    // Arrange
    const label = 'Test Item';
    const icon = Icons.star;
    const size = ComponentSize.lg;

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: SFItem(label: label, icon: icon, size: size)),
      ),
    );

    // Assert
    final sfItem = tester.widget<SFItem>(find.byType(SFItem));
    expect(sfItem.size, size);
  });

  testWidgets('SFItem should use custom iconColor when specified', (
    WidgetTester tester,
  ) async {
    // Arrange
    const label = 'Test Item';
    const icon = Icons.star;
    const customColor = Colors.red;

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SFItem(label: label, icon: icon, iconColor: customColor),
        ),
      ),
    );

    // Assert
    final sfItem = tester.widget<SFItem>(find.byType(SFItem));
    expect(sfItem.iconColor, customColor);

    final iconWidget = tester.widget<Icon>(find.byIcon(icon));
    expect(iconWidget.color, customColor);
  });

  testWidgets(
    'SFItem should use theme primary color when iconColor not specified',
    (WidgetTester tester) async {
      // Arrange
      const label = 'Test Item';
      const icon = Icons.star;
      final theme = ThemeData(primaryColor: Colors.blue);

      // Act
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(body: SFItem(label: label, icon: icon)),
        ),
      );

      // Assert
      final iconWidget = tester.widget<Icon>(find.byIcon(icon));
      expect(iconWidget.color, theme.primaryColor);
    },
  );

  testWidgets('SFItem should apply proper typography style based on size', (
    WidgetTester tester,
  ) async {
    // Arrange
    const label = 'Test Item';
    const icon = Icons.star;
    const size = ComponentSize.sm;

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: SFItem(label: label, icon: icon, size: size)),
      ),
    );

    // Assert
    final textWidget = tester.widget<Text>(find.text(label));
    expect(
      textWidget.style,
      AppTypography.getScaledStyle(AppTypography.labelLarge, size),
    );
  });
}
