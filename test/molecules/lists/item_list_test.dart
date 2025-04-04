import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

void main() {
  testWidgets('SFItemList should render with default properties', (
    WidgetTester tester,
  ) async {
    // Arrange
    final items = [
      SFItemListData(label: 'Item 1'),
      SFItemListData(label: 'Item 2'),
    ];

    // Act
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: SFItemList(items: items))),
    );

    // Assert
    expect(find.byType(SFItemList), findsOneWidget);
    expect(find.byType(SFItem), findsNWidgets(2));
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_outline_rounded), findsNWidgets(2));
  });

  testWidgets('SFItemList should use item icon when provided', (
    WidgetTester tester,
  ) async {
    // Arrange
    final items = [
      SFItemListData(label: 'Item 1', icon: Icons.star),
      SFItemListData(label: 'Item 2'),
    ];

    // Act
    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: SFItemList(items: items))),
    );

    // Assert
    expect(find.byIcon(Icons.star), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_outline_rounded), findsOneWidget);
  });

  testWidgets('SFItemList should use custom default icon when provided', (
    WidgetTester tester,
  ) async {
    // Arrange
    final items = [
      SFItemListData(label: 'Item 1'),
      SFItemListData(label: 'Item 2'),
    ];

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SFItemList(items: items, defaultIcon: Icons.favorite),
        ),
      ),
    );

    // Assert
    expect(find.byIcon(Icons.favorite), findsNWidgets(2));
    expect(find.byIcon(Icons.check_circle_outline_rounded), findsNothing);
  });

  testWidgets('SFItemList should pass size to SFItem', (
    WidgetTester tester,
  ) async {
    // Arrange
    final items = [SFItemListData(label: 'Item 1')];

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: SFItemList(items: items, size: ComponentSize.lg)),
      ),
    );

    // Assert
    final sfItem = tester.widget<SFItem>(find.byType(SFItem));
    expect(sfItem.size, ComponentSize.lg);
  });

  testWidgets('SFItemList should pass custom iconColor to SFItem', (
    WidgetTester tester,
  ) async {
    // Arrange
    final items = [SFItemListData(label: 'Item 1')];
    const customColor = Colors.red;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: SFItemList(items: items, iconColor: customColor)),
      ),
    );

    // Assert
    final sfItem = tester.widget<SFItem>(find.byType(SFItem));
    expect(sfItem.iconColor, customColor);
  });
}
