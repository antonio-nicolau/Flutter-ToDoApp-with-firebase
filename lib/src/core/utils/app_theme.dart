import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateProvider<bool>((ref) {
  return false;
});

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      colorScheme: isDarkTheme
          ? const ColorScheme.dark(
              secondary: Color(0xff2643C4),
            )
          : const ColorScheme.light(
              secondary: Colors.blue,
            ),
      primaryColor: isDarkTheme ? const Color(0xff000000) : const Color(0xffF1F0F6),
      // backgroundColor: isDarkTheme ? const Color(0xff020417) : const Color(0xffF1F5FB),
      indicatorColor: isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      hintColor: isDarkTheme ? const Color(0xff280C0B) : const Color(0xffEECED3),
      highlightColor: isDarkTheme ? const Color(0xff372901) : const Color(0xffFCE192),
      hoverColor: isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
      dividerColor: isDarkTheme ? Colors.white : const Color(0xff9D9AB4),
      focusColor: isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      iconTheme: IconThemeData(
        color: isDarkTheme ? Colors.white : const Color(0xff9D9AB4),
      ),
      cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: isDarkTheme ? const ColorScheme.dark() : const ColorScheme.light(),
          ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(color: isDarkTheme ? Colors.white : const Color(0xff020417)),
        headlineMedium: TextStyle(
          color: isDarkTheme ? const Color(0xff020417) : const Color(0xff9D9AB4),
        ),
        headlineSmall: TextStyle(
          color: isDarkTheme ? const Color(0xff020417) : const Color(0xff9D9AB4),
        ),
        titleMedium: TextStyle(
          color: isDarkTheme ? Colors.white : const Color(0xff9D9AB4),
          fontWeight: FontWeight.bold,
        ),
        titleSmall: TextStyle(
          color: isDarkTheme ? const Color(0xff020417) : const Color(0xff9D9AB4),
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: isDarkTheme ? const Color(0xff020417) : const Color(0xff9D9AB4),
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: isDarkTheme ? Colors.white : const Color(0xff9D9AB4),
        ),
      ),
    );
  }
}
