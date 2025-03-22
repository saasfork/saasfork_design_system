import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:saasfork_design_system/utils/services/notifications/animated_notification.dart';
import 'package:saasfork_design_system/utils/services/notifications/providers/time_provider.dart';

import 'animated_notification_test.mocks.dart';

@GenerateMocks([TimerProvider])
void main() {
  late MockTimerProvider mockTimerProvider;

  setUp(() {
    mockTimerProvider = MockTimerProvider();
  });

  testWidgets('AnimatedNotification initializes correctly', (
    WidgetTester tester,
  ) async {
    AnimatedNotificationState? capturedState;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimatedNotification(
            duration: const Duration(seconds: 3),
            onClose: () {},
            onStateCreated: (state) {
              capturedState = state;
            },
            timerProvider: mockTimerProvider,
            child: const Text('Test Notification'),
          ),
        ),
      ),
    );

    expect(find.text('Test Notification'), findsOneWidget);
    expect(capturedState, isNotNull);
    expect(capturedState!.isClosing, false);
  });

  testWidgets('AnimatedNotification animates on appearance', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimatedNotification(
            duration: const Duration(seconds: 3),
            onClose: () {},
            timerProvider: mockTimerProvider,
            child: const Text('Test Notification'),
          ),
        ),
      ),
    );

    // Test initial opacity (animation start)
    var opacity =
        tester
            .widget<FadeTransition>(find.byType(FadeTransition))
            .opacity
            .value;
    expect(opacity, 0.0); // Initial opacity should be 0

    // Advance animation
    await tester.pump(const Duration(milliseconds: 150));
    opacity =
        tester
            .widget<FadeTransition>(find.byType(FadeTransition))
            .opacity
            .value;
    expect(opacity, greaterThan(0.0));
    expect(opacity, lessThan(1.0));

    // Complete animation
    await tester.pump(const Duration(milliseconds: 150));
    opacity =
        tester
            .widget<FadeTransition>(find.byType(FadeTransition))
            .opacity
            .value;
    expect(opacity, 1.0); // Final opacity should be 1
  });

  testWidgets('calling closeNotification multiple times only executes once', (
    WidgetTester tester,
  ) async {
    int closeCount = 0;
    AnimatedNotificationState? capturedState;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimatedNotification(
            duration: const Duration(seconds: 3),
            onClose: () {
              closeCount++;
            },
            onStateCreated: (state) {
              capturedState = state;
            },
            timerProvider: mockTimerProvider,
            child: const Text('Test Notification'),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Call close multiple times
    capturedState!.closeNotification();
    capturedState!.closeNotification();
    capturedState!.closeNotification();

    // Complete the animation
    await tester.pumpAndSettle();

    // Verify onClose was called only once
    expect(closeCount, 1);
  });
}
