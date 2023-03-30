import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final isDarkThemeProvider = StateProvider<bool>((ref) {
  return false;
});

final themePreferencesProvider = Provider<DarkThemePreference>((ref) {
  return DarkThemePreference();
});

class DarkThemePreference {
  static const themeStatus = "THEME_STATUS";

  setDarkTheme(bool value) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setBool(themeStatus, value);
  }

  Future<bool> getTheme() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(themeStatus) ?? false;
  }
}
