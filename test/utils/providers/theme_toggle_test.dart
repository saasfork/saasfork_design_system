import 'package:flutter_test/flutter_test.dart';
import 'package:saasfork_design_system/utils/providers/theme_toggle.dart';

void main() {
  group('ThemeToggle', () {
    late ThemeToggle themeToggle;

    setUp(() {
      themeToggle = ThemeToggle();
    });

    test('initial value should be false', () {
      expect(themeToggle.isDarkMode, isFalse);
      expect(themeToggle.state, isFalse);
    });

    test('toggleTheme should toggle the isDarkMode value', () {
      // Initial state
      expect(themeToggle.isDarkMode, isFalse);
      expect(themeToggle.state, isFalse);

      // First toggle
      themeToggle.toggleTheme();
      expect(themeToggle.isDarkMode, isTrue);
      expect(themeToggle.state, isTrue);

      // Second toggle
      themeToggle.toggleTheme();
      expect(themeToggle.isDarkMode, isFalse);
      expect(themeToggle.state, isFalse);
    });
  });
}
