import 'package:saasfork_core/saasfork_core.dart';

class ThemeToggle extends StateNotifier<bool> {
  ThemeToggle() : super() {
    setState(false);
  }

  bool get isDarkMode => state ?? false;

  void toggleTheme() {
    setState(!state!);
  }
}
