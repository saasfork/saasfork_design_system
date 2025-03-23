import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeToggleProvider = NotifierProvider<ThemeToggle, bool>(
  () => ThemeToggle(),
);

class ThemeToggle extends Notifier<bool> {
  @override
  bool build() => false;

  bool get isDarkMode => state;

  void toggleTheme() {
    state = !state;
  }

  void resetTheme() {
    state = false;
  }
}
